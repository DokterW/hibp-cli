#!/bin/bash
# hibp-cli v0.4
# Made by Dr. Waldijk
# Have I Been Pwned CLI.
# Read the README.md for more info, but you will find more info here below.
# By running this script you agree to the license terms.
# Config ----------------------------------------------------------------------------
HIBPNAM="Have I Been Pwned (CLI)"
HIBPVER="0.4"
# Install dependencies --------------------------------------------------------------
if [ ! -e /usr/bin/jq ]; then
    FNUOSD=$(cat /etc/system-release | grep -oE '^[A-Z][a-z]+\s' | sed '1s/\s//')
    if [ "$FNUOSD" = "Fedora" ]; then
        sudo dnf -y install jq
    else
        echo "You need to install jq."
        exit
    fi
fi
# Config ----------------------------------------------------------------------------
#if [[ ! -f /usr/bin/jq ]]; then
#    $DUPRSUDO dnf -y install jq
#fi
#if [[ ! -f /usr/bin/curl ]]; then
#    $DUPRSUDO dnf -y install curl
#fi
# Functions -------------------------------------------------------------------------
hibp_head () {
    clear
    echo "$HIBPNAM v$HIBPVER"
    echo ""
}
# -----------------------------------------------------------------------------------
while :; do
    hibp_head
    echo "1. Check if your password has been pwned"
    echo "2. Check if your account has been pwned"
    echo "Q. Quit"
    echo ""
    read -p "> " -s -n1 HIBPKEY
    case "$HIBPKEY" in
        1)
            hibp_head
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
            hibp_head
            echo "Times your password has been pwned: $HIBPPWDCHK"
            echo ""
            read -p "Press any key to continue..." -s -n1
            HIBPPWD=""
            HIBPPWDPRE=""
            HIBPPWDSUF=""
            HIBPPWDRNG=""
            HIBPPWDCHK=""
        ;;
        2)
            hibp_head
            echo "Enter your email address:"
            read -p "> " HIBPPWD
            HIBPPWD=$(curl -s "https://api.pwnedpasswords.com/v2/breachedaccount/$HIBPPWD?truncateResponse=true" | jq -r '.[].Name' | tr '\n' ',' | sed -r 's/,/, /g' | sed -r 's/, $/\n/')
            hibp_head
            echo "These are your services that has been pwned:"
            echo "$HIBPPWD"
            echo ""
            read -p "Press any key to continue..." -s -n1
            HIBPPWD=""
        ;;
        [qQ])
            clear
            break
        ;;
        *)
        ;;
    esac
done
