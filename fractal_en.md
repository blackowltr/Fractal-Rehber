# Fractal Bitcoin Node Setup Guide

Hello.

We are going to set up a node for the [Fractal Bitcoin](https://www.fractalbitcoin.io/) project, which is supported by Binance and will launch its token in September.

You can find the node setup process and detailed guide below.

![Fractal Bıtcoın](https://github.com/user-attachments/assets/b2d78de2-2afd-49c5-bc0c-604f1cfe8831)


## What is Fractal Bitcoin?

Fractal Bitcoin is the only Bitcoin scaling solution that uses the Bitcoin Core code to iteratively scale infinite layers. This is the world's first virtualization method applied to Bitcoin. Fractal gradually expands the Bitcoin blockchain into a scalable computing system without compromising the consistency of the main Bitcoin chain. Building on Fractal is quite simple with powerful tools and support.

### Requirements

| Requirement                  | Description                         |
|------------------------------|-------------------------------------|
| Operating System              | Ubuntu 22.04 or newer               |
| Memory (RAM)                 | At least 4 GB                       |
| Disk Space                   | At least 100 GB of free disk space  |

## Installation

**Note: There are no incentives for running a node. Please proceed with the installation knowing this.**

1. **Install Packages:**

```shell
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
```

## Node Installation

1. **Download the Fractal Repository:**

```shell
wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v0.1.7/fractald-0.1.7-x86_64-linux-gnu.tar.gz
```

2. **Extract the File:**

```shell
tar -zxvf fractald-0.1.7-x86_64-linux-gnu.tar.gz
```

3. **Create the Data Folder:**

```shell
cd fractald-0.1.7-x86_64-linux-gnu && mkdir data
```

4. **Copy the Configuration File:**

```shell
cp ./bitcoin.conf ./data
```

5. **Create a Service:**

```shell
sudo tee /etc/systemd/system/fractald.service > /dev/null <<EOF
[Unit]
Description=Fractal Node
After=network.target

[Service]
User=root
WorkingDirectory=/root/fractald-0.1.7-x86_64-linux-gnu
ExecStart=/root/fractald-0.1.7-x86_64-linux-gnu/bin/bitcoind -datadir=/root/fractald-0.1.7-x86_64-linux-gnu/data/ -maxtipage=504576000
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

**Log Check**

```bash
sudo journalctl -u fractald -fo cat
```

### 7. Create a Wallet

Create a wallet by running the following commands sequentially:

```shell
cd /root/fractald-0.1.7-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=wallet -legacy create
```
As a result of these steps, you will have created a new wallet named `wallet`.

![Ekran Resmi 2024-07-25 23 40 11](https://github.com/user-attachments/assets/347d7ae9-5de4-42de-a0cc-9c7b7edef409)

8. **Get the Wallet Private Key:**
> You can find out your private key with the following command. There is no need to change anything in the command.
```shell
cd /root/fractald-0.1.7-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=/root/.bitcoin/wallets/wallet/wallet.dat -dumpfile=/root/.bitcoin/wallets/wallet/MyPK.dat dump
cd && awk -F 'checksum,' '/checksum/ {print "Your Wallet Private Key:" $2}' .bitcoin/wallets/wallet/MyPK.dat
```

### Node Removal
```shell
curl -s https://raw.githubusercontent.com/blackowltr/Fractal-Rehber/main/delete.sh | bash
```
---------

# Importing Wallet to Unisat Wallet

1. **Download [Unisat Wallet](https://chromewebstore.google.com/detail/unisat-wallet/ppbibelpcjmhbdihakflkdcoccbgbkpo?pli=1)**
   - Open the wallet.

![1  (4)](https://github.com/user-attachments/assets/a5cb92dc-417b-4868-bcbb-68e24e3dd354)

2. **Enter the Settings Menu**
   - Click on wallet #1 in the top left corner of the screen and then click on the "+" icon in the top right corner.

![1](https://github.com/user-attachments/assets/116dedbd-a1f8-44cf-b7dd-828d6efe4207)

4. **Restore with Private Key**
   - Select the "Restore with single private key" option.

![1  (1)](https://github.com/user-attachments/assets/ada6a10e-0c6b-4007-8acf-18376100e426)

5. **Paste the Private Key**
   - Paste the given private key into the appropriate field.

![1  (2)](https://github.com/user-attachments/assets/1e61209c-1128-4bd6-a87e-f8ed96924fc6)

8. **Select Wallet Type**
   - Choose "Legacy" as the wallet type.

![1  (3)](https://github.com/user-attachments/assets/09497321-4475-4831-8ff6-d786d0fe295d)

* Fractal Explorer: [https://explorer.fractalbitcoin.io/](https://explorer.fractalbitcoin.io/)

**[Don't forget to follow me on X](https://x.com/brsbtc)**
