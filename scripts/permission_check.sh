#!/bin/bash

FILE="database_password.txt"

echo "================================"
echo " Linux Security Audit"
echo "================================"

if [ -f "$FILE" ]; then
    echo "File found: $FILE"

    PERMISSIONS=$(stat -c "%a" "$FILE")
    echo "Current permissions: $PERMISSIONS"

    if [ "$PERMISSIONS" = "600" ]; then
        echo "PASS: File permissions are secure."
    else
        echo "WARNING: File permissions should be 600."
        echo "Fix with: chmod 600 $FILE"
    fi
else
    echo "WARNING: $FILE does not exist"
fi
