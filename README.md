# Linux Security Audit Tool

A Bash-based Linux security auditing project that checks file permissions, identifies potential security risks, and generates audit reports.

## Project Overview

This project demonstrates practical Linux security auditing using Bash scripting.

It contains two versions:

- **Version 1:** Checks permissions on a sensitive file and reports whether the permissions match the recommended mode of 600.
- **Version 2:** Recursively scans a selected directory, identifies permission-related security findings, handles access errors, and generates an audit report.

## Features

### Version 1 — Sensitive File Permission Checker

- Checks whether a sensitive file exists.
- Reads file permissions using `stat`.
- Checks whether permissions match mode `600`.
- Displays PASS or WARNING results.
- Suggests a manual permission correction.

### Version 2 — Directory Security Scanner

- Recursively scans regular files in a selected directory.
- Detects sensitive-looking filenames containing `password` or `credential` when group or others have read permission.
- Detects files writable by group or others.
- Reports findings without automatically changing permissions.
- Continues scanning when it encounters inaccessible directories.
- Counts scanned files, security findings, and access errors.
- Displays only security findings in the terminal.
- Generates a detailed report at `reports/audit_report.txt`.
- Does not follow symbolic links during file discovery.

## Security Rules

| Condition | Severity |
|---|---|
| Sensitive-looking file readable by group or others | HIGH |
| File writable by group or others | HIGH |

The scanner is a learning project and does not replace a professional security audit.

## Technologies

- Linux / Ubuntu (WSL)
- Bash scripting
- Git and GitHub
- Linux commands: `find`, `stat`, `chmod`, `mktemp`, `date`

## Project Structure

```text
linux-security-audit/
├── .gitignore
├── README.md
├── reports/
│   └── audit-summary.md
└── scripts/
    ├── permission_check.sh
    └── directory_scanner.sh
```

## How to Run

### Version 1

```bash
bash scripts/permission_check.sh
```

### Version 2

```bash
bash scripts/directory_scanner.sh test-data
```

The Version 2 scanner requires one existing target directory as an argument.

## Remediation Approach

The scanner uses a report-only approach. It identifies potential permission problems but does not modify file permissions automatically. Users can review the findings and decide how to fix them.

## Learning Objectives

- Understand Linux file permissions.
- Practice Bash scripting and conditional statements.
- Discover files recursively using `find`.
- Inspect file metadata using `stat`.
- Handle temporary files and access errors.
- Generate security audit reports.
- Use Git and GitHub to manage a practical project.
