#!/bin/bash

# Global variables
FRACTALD_DIR=$(find /root -type d -name "fractald-*-x86_64-linux-gnu")
ARCHIVE_PATTERN="/root/fractald-*-x86_64-linux-gnu.tar.gz"
SERVICE_FILE="/etc/systemd/system/fractald.service"

# Function to remove the Fractal Node directory
remove_fractald_dir() {
    if [ -n "$FRACTALD_DIR" ]; then
        printf "Fractal Node dizini bulundu: %s\n" "$FRACTALD_DIR"
        sudo rm -rf "$FRACTALD_DIR" || {
            printf "Fractal Node dizini silinemedi.\n" >&2
            return 1
        }
        printf "Fractal Node dizini silindi.\n"
    else
        printf "Fractal Node dizini bulunamadı.\n"
    fi
}

# Function to remove the Fractal Node archive files
remove_fractald_archives() {
    local archives; archives=$(find /root -type f -name "fractald-*-x86_64-linux-gnu.tar.gz")
    
    if [ -n "$archives" ]; then
        printf "Arşiv dosyaları bulundu:\n%s\n" "$archives"
        sudo rm -f $ARCHIVE_PATTERN || {
            printf "Arşiv dosyaları silinemedi.\n" >&2
            return 1
        }
        printf "Arşiv dosyaları silindi.\n"
    else
        printf "Herhangi bir arşiv dosyası bulunamadı.\n"
    fi
}

# Function to disable and remove the Fractal Node service
remove_fractald_service() {
    sudo systemctl stop fractald || {
        printf "Fractal Node servisi durdurulamadı.\n" >&2
        return 1
    }

    sudo systemctl disable fractald || {
        printf "Fractal Node servisi devre dışı bırakılamadı.\n" >&2
        return 1
    }

    if [ -f "$SERVICE_FILE" ]; then
        sudo rm "$SERVICE_FILE" || {
            printf "Servis dosyası silinemedi.\n" >&2
            return 1
        }
        sudo systemctl daemon-reload || {
            printf "Systemd daemon yeniden yüklenemedi.\n" >&2
            return 1
        }
        printf "Fractal Node servisi kaldırıldı.\n"
    else
        printf "Servis dosyası bulunamadı.\n"
    fi
}

# Main function
main() {
    remove_fractald_dir
    remove_fractald_archives
    remove_fractald_service
}

main
