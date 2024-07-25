#!/bin/bash

# Global variables
PACKAGE_LIST="curl build-essential pkg-config libssl-dev git wget jq make gcc chrony"
NODE_VERSION="1.0.6"
NODE_NAME="fractald"
NODE_ARCHIVE="${NODE_NAME}-${NODE_VERSION}-x86_64-linux-gnu.tar.gz"
NODE_URL="https://github.com/fractal-bitcoin/fractald-release/releases/download/v${NODE_VERSION}/${NODE_ARCHIVE}"
NODE_DIR="/root/${NODE_NAME}-${NODE_VERSION}-x86_64-linux-gnu"
DATA_DIR="${NODE_DIR}/data"
CONFIG_FILE="bitcoin.conf"
SERVICE_FILE="/etc/systemd/system/${NODE_NAME}.service"

# Function to install packages
install_packages() {
    if ! sudo apt update && sudo apt upgrade -y; then
        printf "Failed to update and upgrade packages\n" >&2
        return 1
    fi
    if ! sudo apt install -y ${PACKAGE_LIST}; then
        printf "Failed to install necessary packages\n" >&2
        return 1
    fi
}

# Function to download the node
download_node() {
    if ! wget ${NODE_URL}; then
        printf "Failed to download the node archive\n" >&2
        return 1
    fi
    if ! tar -zxvf ${NODE_ARCHIVE}; then
        printf "Failed to extract the node archive\n" >&2
        return 1
    fi
}

# Function to setup the node data directory
setup_data_directory() {
    if ! cd ${NODE_DIR} || ! mkdir -p ${DATA_DIR}; then
        printf "Failed to create data directory\n" >&2
        return 1
    fi
    if ! cp ./${CONFIG_FILE} ${DATA_DIR}; then
        printf "Failed to copy configuration file\n" >&2
        return 1
    fi
}

# Function to create systemd service
create_service() {
    if ! tee ${SERVICE_FILE} > /dev/null <<EOF
[Unit]
Description=Fractal Node
After=network.target
[Service]
User=root
ExecStart=${NODE_DIR}/bin/bitcoind -datadir=${DATA_DIR} -maxtipage=504576000
Restart=always
RestartSec=3
LimitNOFILE=infinity
[Install]
WantedBy=multi-user.target
EOF
    then
        printf "Failed to create systemd service file\n" >&2
        return 1
    fi
    if ! sudo systemctl daemon-reload; then
        printf "Failed to reload systemd daemon\n" >&2
        return 1
    fi
    if ! sudo systemctl enable ${NODE_NAME}; then
        printf "Failed to enable the service\n" >&2
        return 1
    fi
    if ! sudo systemctl start ${NODE_NAME}; then
        printf "Failed to start the service\n" >&2
        return 1
    fi
}

# Function to create wallet
create_wallet() {
    printf "Would you like to create a wallet now? (yes/no): "
    read -r response
    if [[ "${response}" == "yes" ]]; then
        if ! cd ${NODE_DIR}/bin || ! ./bitcoin-wallet -wallet=wallet -legacy create; then
            printf "Failed to create wallet\n" >&2
            return 1
        fi
        printf "Wallet 'wallet' created successfully.\n"
    else
        printf "Skipping wallet creation.\n"
    fi
}

# Function to get wallet private key
get_wallet_private_key() {
    printf "Would you like to retrieve your wallet private key now? (yes/no): "
    read -r response
    if [[ "${response}" == "yes" ]]; then
        if ! cd ${NODE_DIR}/bin || ! ./bitcoin-wallet -wallet=/root/.bitcoin/wallets/wallet/wallet.dat -dumpfile=/root/.bitcoin/wallets/wallet/MyPK.dat dump; then
            printf "Failed to dump wallet private key\n" >&2
            return 1
        fi
        if ! cd && ! awk -F 'checksum,' '/checksum/ {print "Cüzdan Private Keyiniz:" $2}' .bitcoin/wallets/wallet/MyPK.dat; then
            printf "Failed to retrieve wallet private key\n" >&2
            return 1
        fi
    else
        printf "Skipping wallet private key retrieval.\n"
    fi
}

# Main function
main() {
    if ! install_packages; then
        printf "Package installation failed\n" >&2
        return 1
    fi
    if ! download_node; then
        printf "Node download failed\n" >&2
        return 1
    fi
    if ! setup_data_directory; then
        printf "Data directory setup failed\n" >&2
        return 1
    fi
    if ! create_service; then
        printf "Service creation failed\n" >&2
        return 1
    fi
    if ! create_wallet; then
        printf "Wallet creation process failed\n" >&2
        return 1
    fi
    if ! get_wallet_private_key; then
        printf "Wallet private key retrieval process failed\n" >&2
        return 1
    fi
    printf "Fractal Node setup completed successfully\n"
}

main "$@"
