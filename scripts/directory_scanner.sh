#!/usr/bin/env bash

# Check whether the user provided exactly one argument
if [[ $# -ne 1 ]]; then
    echo "Usage: bash scripts/directory_scanner.sh <target_directory>"
    echo "Example: bash scripts/directory_scanner.sh test-data"
    exit 1
fi

# Store the user's selected directory
target_dir="$1"

# Reject a symbolic link as the target directory
if [[ -L "$target_dir" ]]; then
    echo "ERROR: Target directory cannot be a symbolic link."
    exit 1
fi

# Check whether the selected directory exists
if [[ ! -d "$target_dir" ]]; then
    echo "ERROR: Target directory does not exist."
    exit 1
fi

# Count regular files discovered recursively
# Initialize counters
files_scanned=0
findings_count=0
access_errors=0

# Create a temporary working directory
tmp_dir=$(mktemp -d) || {
    echo "ERROR: Could not create temporary directory."
    exit 1
}

# Clean up temporary files when the script exits
trap 'rm -rf -- "$tmp_dir"' EXIT

scan_list="$tmp_dir/scan_list"
find_error_log="$tmp_dir/find_errors"
findings_log="$tmp_dir/findings"
access_log="$tmp_dir/access_errors"

# Discover regular files and record directory access errors
find -P "$target_dir" -type f -print0 > "$scan_list" 2> "$find_error_log"

# Check discovered files
while IFS= read -r -d '' filepath; do

    files_scanned=$((files_scanned + 1))

    mode=$(stat -c '%a' -- "$filepath" 2>/dev/null) || {
        access_errors=$((access_errors + 1))
        echo "ACCESS ERROR: Could not inspect file: $filepath" >> "$access_log"
        continue
    }

    # Check sensitive-looking filenames
    if [[ "$filepath" == *password* || "$filepath" == *credential* ]]; then
        if (( (8#$mode & 8#44) != 0 )); then
            findings_count=$((findings_count + 1))
            echo "HIGH: Sensitive-looking file is readable by group or others: $filepath" >> "$findings_log"
        fi
    fi

    # Check group/others write permission
    if (( (8#$mode & 8#22) != 0 )); then
        findings_count=$((findings_count + 1))
        echo "HIGH: File is writable by group or others: $filepath" >> "$findings_log"
    fi

done < "$scan_list"

# Record directory access errors
while IFS= read -r error_line || [[ -n "$error_line" ]]; do
    access_errors=$((access_errors + 1))
    echo "ACCESS ERROR: $error_line" >> "$access_log"
done < "$find_error_log"

# Create the reports directory
mkdir -p reports || {
    echo "ERROR: Could not create reports directory."
    exit 1
}

# Generate the audit report
report_file="reports/audit_report.txt"

{
    echo "================================"
    echo "      LINUX SECURITY AUDIT"
    echo "================================"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Target directory: $target_dir"
    echo
    echo "SCAN SUMMARY"
    echo "Files scanned: $files_scanned"
    echo "Security findings: $findings_count"
    echo "Access errors: $access_errors"
    echo
    echo "SECURITY FINDINGS"
    if [[ -s "$findings_log" ]]; then
        cat "$findings_log"
    else
        echo "No security findings."
    fi
    echo
    echo "ACCESS ERRORS"
    if [[ -s "$access_log" ]]; then
        cat "$access_log"
    else
        echo "No access errors."
    fi
} > "$report_file"

# Display findings only when findings exist
if [[ -s "$findings_log" ]]; then
    cat "$findings_log"
fi
