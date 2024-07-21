## Fractal Bitcoin Node Installation Guide

Hello,

We will set up a node in the [Fractal Bitcoin](https://www.fractalbitcoin.io/) project, which is supported by Binance and will release its token in September.

You can find the detailed setup process and guide below.

![Fractal Bıtcoın](https://github.com/user-attachments/assets/6c14f2c8-2abb-49e8-888c-b329a73e3c84)

## What is Fractal Bitcoin?

Fractal Bitcoin is the only Bitcoin scaling solution that uses Bitcoin Core code to scale layers recursively. This is the first virtualization method applied to Bitcoin in the world. Fractal gradually expands the Bitcoin blockchain into a scalable computing system without disrupting the consistency on the main Bitcoin chain. Building on Fractal is quite simple with powerful tools and support.

### Requirements

| Requirement                   | Description                            |
|------------------------------|-------------------------------------|
| Operating System              | Ubuntu 22.04 or later version        |
| Memory (RAM)                 | At least 4 GB                          |
| Disk Space                   | At least 100 GB free disk space        |

## Installation 

1. **Install Packages:**

```shell
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
```

2. **Clone the Fractal Repository:**

```shell
git clone https://github.com/fractal-bitcoin/fractald-release.git
```

3. **Navigate to the Directory:**

```shell
cd /root/fractald-release/fractald-x86_64-linux-gnu
```

4. **Create the Data Folder:**

```shell
mkdir data
```

5. **Copy the Configuration File:**

```shell
cp ./bitcoin.conf ./data
```

6. **Create the Service:**

```shell
tee /etc/systemd/system/fractald.service > /dev/null <<EOF
[Unit]
Description=Fractal Node
After=network.target
[Service]
User=root
ExecStart=/root/fractald-release/fractald-x86_64-linux-gnu/bin/bitcoind -datadir=/root/fractald-release/fractald-x86_64-linux-gnu/data/ -maxtipage=504576000
Restart=always
RestartSec=3
LimitNOFILE=infinity
[Install]
WantedBy=multi-user.target
EOF
```

```shell
sudo systemctl daemon-reload && \
sudo systemctl enable fractald && \
sudo systemctl start fractald
```

**Check Logs**
```shell
sudo journalctl -u fractald -fo cat
```

### 7. Create a Wallet

#### 7.1: Define the Wallet Name

First, define a name for the wallet you want to create and assign this name to a variable:

```shell
echo 'export WALLET="your_wallet_name"' >> $HOME/.bashrc && source $HOME/.bashrc
```
> Note: Replace `your_wallet_name` with the name of the wallet you want to create.

#### 7.2: Run the Wallet Creation Commands

Run the following commands in the terminal to create the wallet:

```shell
cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet="$WALLET" -legacy create
```
As a result of these steps, you will have created a new wallet with the specified name.

8. **Get the Wallet Private Key:**
> You can learn your private key with the following command. There is no need to change any part of the command.
```shell
cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=/root/.bitcoin/wallets/$CUZDAN/wallet.dat -dumpfile=/root/.bitcoin/wallets/$CUZDAN/MyPK.dat dump
cd
cat .bitcoin/wallets/$CUZDAN/MyPK.dat
```

![Screenshot 2024-07-15 22 51 53](https://github.com/user-attachments/assets/e3abaf80-6ee2-4ae5-8fc4-dd6debe75819)

* Fractal Explorer: [https://explorer.fractalbitcoin.io/](https://explorer.fractalbitcoin.io/)

**[Don't forget to follow me on X](https://x.com/brsbtc)**
