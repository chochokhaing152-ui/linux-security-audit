# Linux Security Audit Tool

A Bash-based Linux security auditing project that checks sensitive file permissions and identifies potentially insecure configurations.

## Overview

The Linux Security Audit Tool is a hands-on project designed to demonstrate basic Linux security auditing. It checks whether a sensitive file has the recommended permission mode of `600` and reports when permissions are less restrictive.

The project demonstrates practical skills in Linux administration, Bash scripting, file permissions, and security best practices.

## Features

- Checks whether a sensitive file exists.
- Reads file permissions using the Linux `stat` command.
- Detects permissions that do not match the expected `600` mode.
- Displays PASS or WARNING audit results.
- Suggests a command to correct insecure permissions.

## Technologies

- Linux / Ubuntu (WSL)
- Bash scripting
- Git and GitHub
- Linux commands: `chmod`, `stat`, `ls`

## Project Structure

linux-security-audit/
├── .gitignore
├── README.md
├── reports/
└── scripts/
    └── permission_check.sh


## Prerequisites

- Ubuntu or another Linux environment
- Bash shell
- Git

## Getting Started

### 1. Clone the repository

git clone https://github.com/chochokhaing152-ui/linux-security-audit.git
cd linux-security-audit


### 2. Prepare a dummy test file

The sensitive test file is intentionally excluded from GitHub. Create your own dummy file:


echo "dummy-password" > database_password.txt
chmod 600 database_password.txt


Never use a real password or production secret.

### 3. Make the script executable


chmod +x scripts/permission_check.sh


### 4. Run the security audit

./scripts/permission_check.sh


## Example Output

### Secure permissions (600)

================================
 Linux Security Audit
================================
File found: database_password.txt
Current permissions: 600
PASS: File permissions are secure.


### Insecure permissions (644)

================================
 Linux Security Audit
================================
File found: database_password.txt
Current permissions: 644
WARNING: File permissions should be 600.
Fix with: chmod 600 database_password.txt


## Security Best Practices

- Use restrictive permissions for sensitive files.
- Apply the principle of least privilege.
- Never upload real passwords, private keys, or production secrets.
- Use `.gitignore` to exclude sensitive files from Git tracking.

## Learning Objectives

- Understand Linux file permissions and ownership.
- Develop Bash scripts using conditions and variables.
- Practice Linux security auditing.
- Use Git and GitHub for version control.
- Apply basic security principles in a practical project.

## Author

Cloud Computing graduate | Aspiring Junior Cloud Engineer
