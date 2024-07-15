## Bitcoin Fractal Node Kurulum Rehberi (Geliştirilmiş)

Bu rehber, Ubuntu 22.04 veya üzeri işletim sistemi kullananlar için Fractal Bitcoin node kurulumunu adım adım anlatmaktadır. 

* İşletim Sistemi: **Ubuntu 22.04 ve üstü**

**Kurulum:**

1. **Paketlerin Kurulumu:**

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
```

2. **Fractal Reposunu Çekme:**

```bash
screen -S node
git clone https://github.com/fractal-bitcoin/fractald-release.git
```

3. **Dizine Gitme:**

```bash
cd /root/fractald-release/fractald-x86_64-linux-gnu
```

4. **Data Klasörünü Oluşturma:**

```bash
mkdir data
```

5. **Konfigürasyon Dosyasını Kopyalama:**

```bash
cp ./bitcoin.conf ./data
```

6. **Servis Oluşturma:**

```bash
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

```bash
sudo systemctl daemon-reload && \
sudo systemctl enable fractald && \
sudo systemctl start fractald
```

**Log Kontrol**
```
sudo journalctl -u fractald -fo cat
```

7. **Cüzdan Oluşturma:**

```bash
cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=CÜZDANADINIZIYAZIN create
```

**Not:** "CÜZDANADINIZIYAZIN" kısmını, oluşturmak istediğiniz cüzdanın adıyla değiştirin.

**Ek Kaynaklar:**

* Fractal Explorer: [https://explorer.fractalbitcoin.io/](https://explorer.fractalbitcoin.io/)

