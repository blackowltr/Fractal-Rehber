## Fractal Bitcoin Node Installation Guide

Hello.

We will set up a node for the [Fractal Bitcoin](https://www.fractalbitcoin.io/) project, supported by Binance and launching its token in September.

Below you will find the installation process and detailed guide.

![image](https://github.com/user-attachments/assets/7e9c98e5-d1e9-4a4f-a59f-4997a0e86d8e)

## What is Fractal Bitcoin?

Fractal Bitcoin is the only Bitcoin scaling solution that uses the Bitcoin Core code to scale infinite layers iteratively. This is the world's first virtualization method applied to Bitcoin. Fractal gradually expands the Bitcoin blockchain into a scalable computing system without disrupting the consistency on the main Bitcoin chain. Building on Fractal is quite simple with powerful tools and support.

### Requirements

| Requirement                  | Description                         |
|------------------------------|-------------------------------------|
| Operating System             | Ubuntu 22.04 or newer               |
| Memory (RAM)                 | At least 4 GB                       |
| Disk Space                   | At least 100 GB free disk space     |

## Single Command Installation

```bash
bash <(curl -s https://raw.githubusercontent.com/blackowltr/Fractal-Rehber/main/en-fractal.sh) &>/dev/null
```
## Manuel Installation

1. **Install Packages:**

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
```

## Node Installation

1. **Download the Fractal Repository:**

```bash
wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v1.0.6/fractald-1.0.6-x86_64-linux-gnu.tar.gz
```

2. **Extract the File:**

```bash
tar -zxvf fractald-1.0.6-x86_64-linux-gnu.tar.gz
```

3. **Create the Data Folder:**

```bash
cd fractald-1.0.6-x86_64-linux-gnu && mkdir data
```

4. **Copy the Configuration File:**

```bash
cp ./bitcoin.conf ./data
```

5. **Create the Service:**

```bash
sudo tee /etc/systemd/system/fractald.service > /dev/null <<EOF
[Unit]
Description=Fractal Node
After=network.target

[Service]
User=root
WorkingDirectory=/root/fractald-1.0.6-x86_64-linux-gnu
ExecStart=/root/fractald-1.0.6-x86_64-linux-gnu/bin/bitcoind -datadir=/root/fractald-1.0.6-x86_64-linux-gnu/data/ -maxtipage=504576000
Restart=always
RestartSec=3
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
```

```bash
sudo systemctl daemon-reload && \
sudo systemctl enable fractald && \
sudo systemctl start fractald
```

**Check Logs**

```bash
sudo journalctl -u fractald -fo cat
```

### 7. Create a Wallet

Create a wallet by running the following commands in the terminal:

```shell
cd /root/fractald-1.0.6-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=wallet -legacy create
```
As a result of these steps, you will have created a new wallet named `wallet`.

![Screenshot 2024-07-25 23 40 11](https://github.com/user-attachments/assets/347d7ae9-5de4-42de-a0cc-9c7b7edef409)

8. **Retrieve Wallet Private Key:**
> You can find out your private key using the following command. No need to change anything in the command.
```shell
cd /root/fractald-1.0.6-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=/root/.bitcoin/wallets/wallet/wallet.dat -dumpfile=/root/.bitcoin/wallets/wallet/MyPK.dat dump
cd && awk -F 'checksum,' '/checksum/ {print "Cüzdan Private Keyiniz:" $2}' .bitcoin/wallets/wallet/MyPK.dat
```
---------

# Import Wallet into Unisat Wallet

1. **[Download](https://chromewebstore.google.com/detail/unisat-wallet/ppbibelpcjmhbdihakflkdcoccbgbkpo?pli=1) Unisat Wallet**
   - Open the wallet.

![1  (4)](https://github.com/user-attachments/assets/a5cb92dc-417b-4868-bcbb-68e24e3dd354)

2. **Enter Settings Menu**
   - Click on wallet #1 at the top left of the screen and then click on the "+" icon at the top right.

![1](https://github.com/user-attachments/assets/116dedbd-a1f8-44cf-b7dd-828d6efe4207)

4. **Restore with Private Key**
   - Select the "Restore from single private key" option.

![1  (1)](https://github.com/user-attachments/assets/ada6a10e-0c6b-4007-8acf-18376100e426)

5. **Paste the Private Key**
   - Paste the given private key into the relevant field.

![1  (2)](https://github.com/user-attachments/assets/1e61209c-1128-4bd6-a87e-f8ed96924fc6)

8. **Select Wallet Type**
   - Check the "Legacy" option for wallet type.

![1  (3)](https://github.com/user-attachments/assets/09497321-4475-4831-8ff6-d786d0fe295d)

* Fractal Explorer: [https://explorer.fractalbitcoin.io/](https://explorer.fractalbitcoin.io/)

**[Don't forget to follow me on X](https://x.com/brsbtc)**
