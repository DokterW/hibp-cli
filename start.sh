#!/bin/bash
# hibp-cli v0.1
# Made by Dr. Waldijk
# Have I Been Pwned CLI.
# Read the README.md for more info, but you will find more info here below.
# By running this script you agree to the license terms.
# Config ----------------------------------------------------------------------------
HIBPNAM="Have I Been Pwned (CLI)"
HIBPVER="0.1"
# -----------------------------------------------------------------------------------
clear
echo "$HIBPNAM v$HIBPVER"
echo ""
echo "Enter password:"
read -p "> " -s HIBPPWD
HIBPPWD=$(echo -n "$HIBPPWD" | sha1sum | sed -r 's/([A-Za-z0-9]+).*/\1/' | tr '[:lower:]' '[:upper:]')
HIBPPWDPRE=$(echo "$HIBPPWD" | cut -c -5)
HIBPPWDSUF=$(echo "$HIBPPWD" | cut -c 6-)
HIBPPWDRNG=$(curl -s "https://api.pwnedpasswords.com/range/$HIBPPWDPRE")
HIBPPWDCHK=$(echo "$HIBPPWDRNG" | grep $HIBPPWDSUF)
if [[ -n "$HIBPPWDCHK" ]]; then
    HIBPPWDCHK=$(echo "$HIBPPWDCHK" | sed -r 's/.*:(.*)/\1/')
else
    HIBPPWDCHK="0"
fi
clear
echo "$HIBPNAM v$HIBPVER"
echo ""
echo "Times your password has been pwned: $HIBPPWDCHK"
read -s -n1
clear
