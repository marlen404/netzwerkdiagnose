#!/bin/bash

# Test Projekt - Netzwerk Diagnose
# Autorin: Marlen
# unter MSYS2/MinGW4 auf Windows

: '
Variablen
$ Referenz
unveränderbar: readonly X=3
Argumente: $0 (Skriptname) bis max $9
Anzahl Argumente: $#
Alle Argumente: $@ oder $*
Prozess ID: $$
Exit-Status des letzten Befehls: $? (0 Erfolg, 1 Fehler)
'
: '
Verzweigung mit erweiterten Funktionen [[]] (weniger portabel & fehleranfällig):
if [[ "$1" =~ ^[a-zA-Z]+$ ]]; then
    echo "\nonly letters"
else
    echo "\nnot only letters"
fi
'

: '
read -p "dein Name?" name
echo -e "\nhi $name"

-sp: Eingabe versteckt
'

: '
Schleifen (kein Scoping/Geltungsbereich von i):
for i in {0..8}; do
    echo "Zahl: $i"
done

komplexer:
for ((i=0; i<=4; i++)); do
done
'

log_section() {
    echo -e "\n$1" | tee -a "$LOG_FILE"
    echo "-----------------------------" | tee -a "$LOG_FILE"
}

run_ping_test() {
    log_section "Ping Test to $TARGET_HOST"
    powershell.exe ping -n 4 "$TARGET_HOST" | tee -a "$LOG_FILE"
    if [ $? -eq 0 ]; then
        echo "Ping successful" | tee -a "$LOG_FILE"
    else
        echo "Ping not successful" | tee -a "$LOG_FILE"
    fi
}

run_dns_lookup() {
    log_section "DNS Lookup for $DNS_DOMAIN"
    powershell.exe nslookup "$DNS_DOMAIN" | tee -a "$LOG_FILE"
    if [ $? -eq 0 ]; then
        echo "DNS Lookup successful" | tee -a "$LOG_FILE"
    else
        echo "DNS Lookup unsuccessful" | tee -a "$LOG_FILE"
    fi
}

show_ip_config() {
    log_section "IP Configuration"
    powershell.exe ipconfig /all | tee -a "$LOG_FILE"
}

run_traceroute() {
    log_section "Traceroute to $TARGET_HOST"
    powershell.exe tracert "$TARGET_HOST" | tee -a "$LOG_FILE"
}

show_hostname() {
    log_section "Local Host Name"
    hostname | tee -a "$LOG_FILE"
}