# Linux Security Audit Report

## Project
Linux Security Audit Tool

## Audit Objective
Identify potentially insecure Linux file permissions and report security findings.

## Version 1 — Permission Checker

- Checks a sensitive file's permissions.
- Expects permission mode 600.
- Reports PASS for secure permissions and WARNING for insecure permissions.

## Version 2 — Directory Security Scanner

- Recursively scans regular files in a selected directory.
- Identifies sensitive-looking files readable by group or others.
- Identifies files writable by group or others.
- Reports access errors.
- Generates a detailed audit report.
- Does not automatically modify permissions.

## Test Results

| Test | Expected Result | Result |
|---|---|---|
| Sensitive file with permission 644 | Security finding | Passed |
| File with permission 777 | Security finding | Passed |
| Ordinary file with permission 644 | No finding | Passed |
| Clean directory | No security findings | Passed |
| Inaccessible directory | Access error reported | Passed |

## Security Recommendation

Sensitive files should have restrictive permissions. For example, chmod 600 allows only the owner to read and write a file.

Review scanner findings and apply corrections manually.

## Tools and Technologies

Bash, Ubuntu (WSL), Linux permissions, find, stat, chmod, mktemp, Git and GitHub.
