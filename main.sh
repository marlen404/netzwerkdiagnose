#!/bin/bash


# Zielhost: erstes Argument oder Standard 8.8.8.8
TARGET_HOST=${1:-8.8.8.8}
DNS_DOMAIN="google.com"
LOG_FILE="netzwerk_diagnose_$(date +%F_%H%M).log"

# Externe Funktionen laden
source ./network_tools.sh

run_all_diagnostics() {
    echo -e "\nStarting Network Diagnosis for host: $TARGET_HOST" | tee -a "$LOG_FILE"
    echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"

    run_ping_test
    run_dns_lookup
    show_ip_config
    run_traceroute
    show_hostname

    echo -e "\nComplete! Results in: $LOG_FILE"
}

# Starten
run_all_diagnostics