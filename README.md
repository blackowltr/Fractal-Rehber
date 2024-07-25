## Fractal Bitcoin Node Kurulum Rehberi

Merhabalar.

Binance tarafından desteklenen ve Eylül ayında tokeni çıkacak olan [Fractal Bitcoin](https://www.fractalbitcoin.io/) projesinde bir node kuracağız. 

Node kurulum süreci ve ayrıntılı rehberi aşağıda bulabilirsiniz.

![image](https://github.com/user-attachments/assets/7e9c98e5-d1e9-4a4f-a59f-4997a0e86d8e)

## Fractal Bitcoin Nedir?

Fractal Bitcoin, sonsuz katmanları yinelemeli olarak ölçeklendirmek için Bitcoin Core kodunu kullanan tek Bitcoin ölçeklendirme çözümüdür. Bu, Bitcoin'e uygulanan dünyadaki ilk sanallaştırma yöntemidir. Fractal, Bitcoin blok zincirini, Bitcoin ana zincirindeki tutarlılığı bozmadan ölçeklenebilir bir bilgi işlem sistemine kademeli olarak genişletir. Güçlü araçlar ve destek ile Fractal üzerine inşa etmek oldukça basittir.

### Gereksinimler

| Gereksinim                   | Açıklama                            |
|------------------------------|-------------------------------------|
| İşletim Sistemi              | Ubuntu 22.04 veya daha yeni bir sürüm |
| Bellek (RAM)                 | En az 4 GB                          |
| Disk Alanı                   | En az 100 GB boş disk alanı         |

## Kurulum

1. **Paketleri Kurun:**

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
```

## Node Kurulumu

1. **Fractal Reposunu Çekme:**

```bash
wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v1.0.6/fractald-1.0.6-x86_64-linux-gnu.tar.gz
```

2. **Dosyayı Çıkarma:**

```bash
tar -zxvf fractald-1.0.6-x86_64-linux-gnu.tar.gz
```

3. **Data Klasörünü Oluşturma:**

```bash
cd fractald-1.0.6-x86_64-linux-gnu && mkdir data
```

4. **Konfigürasyon Dosyasını Kopyalama:**

```bash
cp ./bitcoin.conf ./data
```

5. **Servis Oluşturma:**

```bash
tee /etc/systemd/system/fractald.service > /dev/null <<EOF
[Unit]
Description=Fractal Node
After=network.target
[Service]
User=root
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

**Log Kontrol**

```bash
sudo journalctl -u fractald -fo cat
```

### 7. Cüzdan Oluşturma

#### 7.1: Cüzdan Adını Belirleyin

Öncelikle, oluşturmak istediğiniz cüzdan için bir ad belirleyin ve bu adı bir değişkene atayın:

```shell
echo 'export CUZDAN="cuzdan_adiniz"' >> $HOME/.bashrc && source $HOME/.bashrc
```
> Not: `cuzdan_adiniz` kısmını, oluşturmak istediğiniz cüzdanın adıyla değiştirin.

#### 7.2: Cüzdan Oluşturma Komutlarını Çalıştırın

Terminalde aşağıdaki komutları sırasıyla çalıştırarak cüzdan oluşturun:

```shell
cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet="$CUZDAN" -legacy create
```
Bu adımlar sonucunda, belirlediğiniz isimde yeni bir cüzdan oluşturmuş olacaksınız.

![Ekran Resmi 2024-07-15 22 51 53](https://github.com/user-attachments/assets/e3abaf80-6ee2-4ae5-8fc4-dd6debe75819)

8. **Cüzdan Private Key Alma:**
> Aşağıdaki komutla private keyinizi öğrenebilirsiniz. Komutta herhangi bir yeri değiştirmenize gerek yok.
```shell
cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
./bitcoin-wallet -wallet=/root/.bitcoin/wallets/$CUZDAN/wallet.dat -dumpfile=/root/.bitcoin/wallets/$CUZDAN/MyPK.dat dump
cd
cat .bitcoin/wallets/$CUZDAN/MyPK.dat
```

![Ekran Resmi 2024-07-20 23 51 03](https://github.com/user-attachments/assets/fc101ddd-93c1-4a27-bf27-bf3451fdc1ef)

---------

# Unisat Wallet'a Cüzdan Import Etme

1. **Unisat Wallet'ı [İndirin](https://chromewebstore.google.com/detail/unisat-wallet/ppbibelpcjmhbdihakflkdcoccbgbkpo?pli=1)**
   - Cüzdanı açın.

![Ekran Resmi 2024-07-21 00 00 12](https://github.com/user-attachments/assets/0405f228-71e0-40e2-8066-7f1fc9ec9f4b)

2. **Ayarlar Menüsüne Girin**
   - Ekranın sol üst köşesindeki wallet #1'e tıklayın ve ardından sağ üst köşedeki "+" simgesine tıklayın.

![1](https://github.com/user-attachments/assets/116dedbd-a1f8-44cf-b7dd-828d6efe4207)

4. **Private Key ile Geri Yükleme**
   - "Single private key geri yükle" seçeneğini seçin.

![1  (1)](https://github.com/user-attachments/assets/ada6a10e-0c6b-4007-8acf-18376100e426)

5. **Private Key’i Yapıştırın**
   - Size verilen private key’i ilgili alana yapıştırın.

![1  (2)](https://github.com/user-attachments/assets/1e61209c-1128-4bd6-a87e-f8ed96924fc6)

8. **Cüzdan Türünü Seçin**
   - Cüzdan türü olarak "Legacy" seçeneğini işaretleyin.

![1  (3)](https://github.com/user-attachments/assets/09497321-4475-4831-8ff6-d786d0fe295d)

* Fractal Explorer: [https://explorer.fractalbitcoin.io/](https://explorer.fractalbitcoin.io/)

**[Beni X'te takip etmeyi unutmayın](https://x.com/brsbtc)**
