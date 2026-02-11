# Recon Automation Script

Project ini dibuat untuk tugas **Automation & Scripting**. 
Script ini menjalankan proses reconnaissance otomatis mulai dari mencari subdomain sampai mengecek website yang aktif.

## Struktur Folder
- `input/`: Tempat menaruh list domain target (`domains.txt`)
- `output/`: Hasil scan (`live.txt` dan `all-subdomains.txt`)
- `scripts/`: Script utama (`recon-auto.sh`)
- `logs/`: Catatan log error dan progress

## Cara Install Tools
Pastikan sudah install Go-lang, lalu jalankan:

```bash
go install -v [github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest](https://github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest)
go install -v [github.com/projectdiscovery/httpx/cmd/httpx@latest](https://github.com/projectdiscovery/httpx/cmd/httpx@latest)
go install -v [github.com/tomnomnom/anew@latest](https://github.com/tomnomnom/anew@latest)
