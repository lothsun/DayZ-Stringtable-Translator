# DayZ Stringtable Translator

A simple PowerShell + Batch utility that automates the translation of stringtable CSV files used in DayZ modding. It reads an input CSV containing language columns and fills in missing translations using Google Translate — outputting a clean and compatible CSV file structured for use in dayz mods.

## 📦 Features

- Automatically translates missing fields based on the `original` English column
- Supports multiple languages (mapped to Google Translate's ISO codes)
- Adds a final empty column to conform to DayZ stringtable format
- Drag-and-drop interface — just drop your CSV onto a `.bat` file

## 🛠 Requirements

- Windows with PowerShell 5.0+
- Internet connection (for live translations via Google Translate)
- Standard DayZ stringtable file. Example is included in this repo with correct headers that you can use to create your own stringtable. 

## 🚀 How to Use

1. Clone or download the repository.
2. Place your `stringtable.csv` file in the same folder.
3. Drag and drop the file onto `drophere.bat`.
4. Wait for translations to complete.
5. A new file will be created as `translated_stringtable.csv`.

### 📁 Folder Structure

```
DayZ Stringtable Translator/
├── Translate-CSV.ps1         # Translation logic
├── drophere.bat         # Drag-and-drop launcher
└── stringtable.csv           # Your input file (you provide)
```

## 🌍 Supported Languages

| Column Name   | Language Code | Description        |
|---------------|----------------|--------------------|
| english       | `en`           | English            |
| czech         | `cs`           | Czech              |
| german        | `de`           | German             |
| russian       | `ru`           | Russian            |
| polish        | `pl`           | Polish             |
| hungarian     | `hu`           | Hungarian          |
| italian       | `it`           | Italian            |
| spanish       | `es`           | Spanish            |
| french        | `fr`           | French             |
| chinese       | `zh-TW`        | Traditional Chinese|
| chinesesimp   | `zh-CN`        | Simplified Chinese |
| japanese      | `ja`           | Japanese           |
| portuguese    | `pt`           | Portuguese         |

> **Note:** Language codes are mapped internally and must match column headers exactly in the CSV.

## ⚠️ Disclaimer

This tool uses Google's unofficial translation API (`translate.googleapis.com`) and is intended for light/moderate use. Excessive automated requests may result in temporary IP blocking by Google.

---

## 📄 License

This project is open-source and free to use under the [MIT License](LICENSE).
