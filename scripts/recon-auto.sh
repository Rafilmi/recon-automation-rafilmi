#!/bin/bash

# Script Recon Otomatis

# Setting Variabel
input="../input/domains.txt"
hasil_sub="../output/all-subdomains.txt"
hasil_live="../output/live.txt"
log_file="../logs/progress.log"
error_file="../logs/errors.log"

# Pindah ke direktori script berada supaya path aman
cd "$(dirname "$0")"

# Fungsi buat log ada jamnya
catat() {
    waktu=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$waktu] $1" | tee -a $log_file
}

# Mulai Script
catat "Script Recon Dimulai"

# Langkah 1: Cek Tools
catat "[*] Mengecek tools..."

# Cek Subfinder
if ! command -v subfinder &> /dev/null; then
    catat "[ERROR] Subfinder belum diinstall."
    exit 1
fi

# Cek Anew
if ! command -v anew &> /dev/null; then
    catat "[ERROR] Anew tidak ditemukan."
    exit 1
fi

# Cek Httpx
if ! command -v httpx &> /dev/null; then
    catat "[ERROR] Tidak ada Httpx."
    exit 1
fi

catat "[OK] Tools lengkap."

# Langkah 2: Main Loop (Enumeration)
catat "[*] Mulai pencarian subdomain..."

# Cek input file
if [ ! -f "$input" ]; then
    catat "[ERROR] File input tidak ada di $input"
    exit 1
fi

while read target; do
    # Skip baris kosong
    if [ -z "$target" ]; then continue; fi

    catat "--> Sedang scan domain: $target"

    # Jalankan subfinder -> buang error ke logs -> filter duplikat pakai anew
    subfinder -d "$target" -silent -all 2>> "$error_file" | anew "$hasil_sub" >> /dev/null

done < "$input"

# Hitung hasil
jumlah=$(cat "$hasil_sub" | wc -l)
catat "[+] Total subdomain unik: $jumlah"

# Langkah 3: Cek Live Host (Httpx)
catat "[*] Cek live host dengan httpx..."

if [ "$jumlah" -gt 0 ]; then
    # Format output: URL [STATUS] [TITLE]
    cat "$hasil_sub" | httpx -silent -title -sc -o "$hasil_live" 2>> "$error_file"

    jumlah_live=$(cat "$hasil_live" | wc -l)
    catat "[+] Selesai. Host yang hidup: $jumlah_live"
    catat "[INFO] Hasil disimpan di folder output."
else
    catat "[WARN] Tidak ada subdomain, skip tahap httpx."
fi

catat "Script Selesai"
