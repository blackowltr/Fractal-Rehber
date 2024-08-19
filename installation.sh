#!/bin/bash

# Global Variables
INSTALL_DIR="/root/fractald-0.1.7-x86_64-linux-gnu"
SERVICE_NAME="fractald"
DATA_DIR="${INSTALL_DIR}/data"
WALLET_DIR="/root/.bitcoin/wallets/wallet"
WALLET_NAME="wallet"
LANGUAGE=""

# Helper Functions
ask_language() {
    while true; do
        printf "\n═══════════════════════════════════════════════\n"
        printf "🌐 Please select a language / Lütfen bir dil seçin:\n"
        printf "═══════════════════════════════════════════════\n"
        printf "1) English\n"
        printf "2) Türkçe\n"
        printf "═══════════════════════════════════════════════\n"
        printf "Choice / Seçim: "
        read -r choice
        case $choice in
            1) LANGUAGE="EN"; break ;;
            2) LANGUAGE="TR"; break ;;
            *) printf "\n❌ Invalid selection. Please try again.\n🚫 Geçersiz seçim. Lütfen tekrar deneyin.\n" ;;
        esac
    done
}

prompt_user() {
    local message_en="$1"
    local message_tr="$2"
    local user_input

    if [[ "$LANGUAGE" == "EN" ]]; then
        printf "%s" "$message_en"
    else
        printf "%s" "$message_tr"
    fi
    read -r user_input
    printf "%s" "$user_input"
}

print_message() {
    local message_en="$1"
    local message_tr="$2"

    if [[ "$LANGUAGE" == "EN" ]]; then
        printf "\n✨ %s\n" "$message_en"
    else
        printf "\n✨ %s\n" "$message_tr"
    fi
}

install_dependencies() {
    print_message "Installing required packages..." "Gerekli paketler yükleniyor..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
}

download_fractald() {
    print_message "Downloading Fractal Node..." "Fractal Node indiriliyor..."
    wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v0.1.7/fractald-0.1.7-x86_64-linux-gnu.tar.gz
    tar -zxvf fractald-0.1.7-x86_64-linux-gnu.tar.gz
}

setup_configuration() {
    print_message "Setting up configuration..." "Konfigürasyon ayarlanıyor..."
    mkdir -p "$DATA_DIR"
    cp "$INSTALL_DIR/bitcoin.conf" "$DATA_DIR"
}

create_service() {
    print_message "Creating systemd service..." "systemd servisi oluşturuluyor..."
    sudo tee /etc/systemd/system/${SERVICE_NAME}.service > /dev/null <<EOF
[Unit]
Description=Fractal Node
After=network.target

[Service]
User=root
WorkingDirectory=${INSTALL_DIR}
ExecStart=${INSTALL_DIR}/bin/bitcoind -datadir=${DATA_DIR}/ -maxtipage=504576000
Restart=always
RestartSec=3
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
    sudo systemctl daemon-reload
    sudo systemctl enable "$SERVICE_NAME"
    sudo systemctl start "$SERVICE_NAME"
}

create_wallet() {
    print_message "Creating wallet..." "Cüzdan oluşturuluyor..."
    cd "${INSTALL_DIR}/bin" || exit
    ./bitcoin-wallet -wallet="$WALLET_NAME" -legacy create
}

get_private_key() {
    print_message "Fetching private key..." "Private key alınıyor..."
    ./bitcoin-wallet -wallet="${WALLET_DIR}/wallet.dat" -dumpfile="${WALLET_DIR}/MyPK.dat" dump
    cd || exit
    awk -F 'checksum,' '/checksum/ {print "\n🔐 Your wallet private key is: " $2}' "${WALLET_DIR}/MyPK.dat"
}

check_installation() {
    if [[ -d "$INSTALL_DIR" ]]; then
        return 0
    else
        return 1
    fi
}

remove_node() {
    print_message "Removing Fractal Node..." "Fractal Node kaldırılıyor..."
    curl -s https://raw.githubusercontent.com/blackowltr/Fractal-Rehber/main/delete.sh | bash
    print_message "Fractal Node removed." "Fractal Node kaldırıldı."
}

main_menu() {
    while true; do
        print_message \
        "═══════════════════════════════════════════════\n🛠️  Please choose an option:\n1) Installation\n2) Wallet Creation\n3) Remove Node\n═══════════════════════════════════════════════\nChoice: " \
        "═══════════════════════════════════════════════\n🛠️  Lütfen bir seçenek belirleyin:\n1) Kurulum\n2) Cüzdan Oluşturma\n3) Node Silme\n═══════════════════════════════════════════════\nSeçim: "
        read -r choice
        case $choice in
            1) installation_flow; break ;;
            2) 
                if check_installation; then
                    wallet_creation_flow
                else
                    print_message "❌ Fractal Node is not installed. Please run the installation first." \
                                  "🚫 Fractal Node kurulu değil. Lütfen önce kurulumu yapın."
                fi
                break ;;
            3) 
                if check_installation; then
                    remove_node
                else
                    print_message "❌ Fractal Node is not installed. Cannot remove what is not installed." \
                                  "🚫 Fractal Node kurulu değil. Kurulu olmayan bir şeyi kaldıramazsınız."
                fi
                break ;;
            *) print_message "❌ Invalid selection. Please try again." "🚫 Geçersiz seçim. Lütfen tekrar deneyin." ;;
        esac
    done
}

installation_flow() {
    install_dependencies
    download_fractald
    setup_configuration
    create_service
}

wallet_creation_flow() {
    create_wallet
    get_private_key
}

main() {
    ask_language
    main_menu
}

main
