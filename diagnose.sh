#!/bin/bash

# Test Projekt: Ping and DNS Lookup
# Autorin: Marlen

# unter MSYS2/MinGW4 auf Windows

LOG_FILE="netzwerk_diagnose_$(date +%F_%H%M).log"

# Zielhost - erstes Argument oder 8.8.8.8 Standard
TARGET_HOST=${1:-8.8.8.8}

DNS_DOMAIN="google.com"

# "tee -a" liest stdout und schreibt in Datei ohne Überschreiben
echo "Starting Network Diagnosis for host: $TARGET_HOST" | tee -a "$LOG_FILE"
echo "----" | tee -a "$LOG_FILE"

# Ping Test
echo "Ping Test:" | tee -a "$LOG_FILE"
powershell.exe ping -n 4 "$TARGET_HOST" | tee -a "$LOG_FILE"

# 0 Success
if [ $? -eq 0 ]; then
    echo "Ping successful" | tee -a "$LOG_FILE"
else
    echo "Ping not successful" | tee -a "$LOG_FILE"
fi
echo "" | tee -a "$LOG_FILE"

# DNS Lookup
echo "DNS Lookup ($DNS_DOMAIN):" | tee -a "$LOG_FILE"
powershell.exe nslookup "$DNS_DOMAIN" | tee -a "$LOG_FILE"

if [ $? -eq 0 ]; then
    echo "DNS Lookup successful" | tee -a "$LOG_FILE"
else
    echo "DNS Lookup unsuccessful" | tee -a "$LOG_FILE"
fi
echo "" | tee -a "$LOG_FILE"

echo "Done. Results: $LOG_FILE"