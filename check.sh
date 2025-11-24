#!/bin/bash

# Configuration for PENS Captive Portal
BASE_HOST="iac"
DOMAIN=".pens.ac.id"
PORT="8003"
PATH_QUERY="/index.php?zone=eepiswlan"

# Range to scan (e.g., iac1 to iac30)
START=1
END=30

echo "Scanning for active captive portals (https)..."
echo "This may take a moment."

for ((i=START; i<=END; i++)); do
    URL="https://${BASE_HOST}${i}${DOMAIN}:${PORT}${PATH_QUERY}"
    
    # Check connectivity using curl
    # -k: Insecure (ignore SSL certificate errors)
    # -o /dev/null: Discard output body
    # -s: Silent
    # -w "%{http_code}": Print status code
    # --connect-timeout 1: Fail fast if the node isn't there
    HTTP_STATUS=$(curl -k -o /dev/null -s -w "%{http_code}" --connect-timeout 1 "$URL")

    # Logic update: Check if status is NOT 000. 
    # 000 means connection failed/timeout. 
    # Any other code (200, 403, 404, 500) means the server is actually there.
    if [ "$HTTP_STATUS" != "000" ]; then
        echo ""
        echo "[+] FOUND ACTIVE PORTAL: iac$i [HTTP $HTTP_STATUS]"
        echo "    $URL"
        # stop
        break
    else
        # Print a dot for progress
        echo -n "."
    fi
done

echo ""
echo "Scan complete."