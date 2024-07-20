## Bitcoin Fractal Node Kurulum Rehberi

Merhabalar,

Binance tarafından desteklenen ve Eylül ayında tokeni çıkacak olan @fractal_bitcoin projesinde bir node kuracağız. 

Node kurulum süreci ve ayrıntılı rehberi aşağıda bulabilirsiniz.

![image](https://github.com/user-attachments/assets/7e9c98e5-d1e9-4a4f-a59f-4997a0e86d8e)

## Fractal Bitcoin Nedir?

Fractal Bitcoin, sonsuz katmanları yinelemeli olarak ölçeklendirmek için Bitcoin Core kodunu kullanan tek Bitcoin ölçeklendirme çözümüdür. Bu, Bitcoin'e uygulanan dünyadaki ilk sanallaştırma yöntemidir. Fractal, Bitcoin blok zincirini, Bitcoin ana zincirindeki tutarlılığı bozmadan ölçeklenebilir bir bilgi işlem sistemine kademeli olarak genişletir. Güçlü araçlar ve destek ile Fractal üzerine inşa etmek oldukça basittir.

## Node Kurulum Rehberi

### Gereksinimler

- Ubuntu 22.04 veya daha yeni bir sürüm
- En az 4 GB RAM
- En az 100 GB boş disk alanı

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
./bitcoin-wallet -wallet=CÜZDAN_ADINIZ -legacy create
```
**Not:** `CÜZDAN_ADINIZ` kısmını, oluşturmak istediğiniz cüzdanın adıyla değiştirin.

8. **Cüzdan Private Key Alma:**
```bash
cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
```
```bash
./bitcoin-wallet -wallet=/root/.bitcoin/wallets/CUZDAN_ADINIZ/wallet.dat -dumpfile=/root/.bitcoin/wallets/CUZDAN_ADINIZ/MyPK.dat dump
```

![Ekran Resmi 2024-07-15 22 51 53](https://github.com/user-attachments/assets/e3abaf80-6ee2-4ae5-8fc4-dd6debe75819)

**Ek Kaynaklar:**

* Fractal Explorer: [https://explorer.fractalbitcoin.io/](https://explorer.fractalbitcoin.io/)

