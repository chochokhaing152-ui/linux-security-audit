# Linux Security Audit Report

## Project
Linux Security Audit Tool

## Audit Objective
Check whether sensitive files have secure Linux permissions.

## Test Results

| Test | Permission | Expected Result | Status |
|---|---|---|---|
| Secure file | 600 | PASS | Passed |
| Insecure file | 644 | WARNING | Passed |

## Security Recommendation
Use chmod 600 for sensitive files so only the file owner can read and write them.

## Tool
Bash, Ubuntu, Linux stat and chmod commands.
