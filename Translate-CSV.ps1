param (
    [string]$inputPath
)

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    exit
}

$outputPath = Join-Path -Path (Split-Path $inputPath) -ChildPath ("translated_" + (Split-Path $inputPath -Leaf))
$tempOutput = [System.IO.Path]::ChangeExtension($outputPath, ".tmp.csv")
$data = Import-Csv $inputPath

# Get column headers and skip the first two
$allColumns = $data[0].PSObject.Properties.Name
$headers = $allColumns | Select-Object -Skip 2

# Language mapping
$languageCodeMap = @{
    "english"     = "en"
    "czech"       = "cs"
    "german"      = "de"
    "russian"     = "ru"
    "polish"      = "pl"
    "hungarian"   = "hu"
    "italian"     = "it"
    "spanish"     = "es"
    "french"      = "fr"
    "chinese"     = "zh-TW"
    "chinesesimp" = "zh-CN"
    "japanese"    = "ja"
    "portuguese"  = "pt"
}

$totalRows = $data.Count
$rowIndex = 1

function Translate-Text($text, $targetLang) {
    $escaped = [System.Net.WebUtility]::UrlEncode($text)
    $url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=$targetLang&dt=t&q=$escaped"

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get -ErrorAction Stop
        return $response[0][0][0]
    } catch {
        Write-Warning "Translation failed for [$targetLang]: $text"
        return $text
    }
}

# Translate and prepare data
foreach ($row in $data) {
    $sourceText = $row.original
    Write-Host "`nTranslating row $rowIndex of $totalRows - Reference: $($row.Language)" -ForegroundColor Cyan
    $rowIndex++

    foreach ($lang in $headers) {
        $langCode = $languageCodeMap[$lang]
        if (-not $langCode) {
            Write-Warning "Skipping unknown language column: $lang"
            continue
        }

        if (-not $row.$lang -or $row.$lang -eq $sourceText) {
            Write-Host "    -> Translating to [$lang] ($langCode)..." -NoNewline
            $translated = Translate-Text -text $sourceText -targetLang $langCode
            $row.$lang = $translated
            Write-Host " done"
            Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 3)
        }
    }
}

# Export normally
$data | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $tempOutput

# Fix header and lines: add a trailing comma to all
$lines = Get-Content $tempOutput
$lines = $lines | ForEach-Object { "$_," }

# Write fixed CSV
Set-Content -Path $outputPath -Value $lines -Encoding UTF8
Remove-Item $tempOutput

Write-Host "`nTranslation complete. CSV saved to: $outputPath" -ForegroundColor Green
