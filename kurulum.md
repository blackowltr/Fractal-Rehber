# Bitcoin Fractal Node Rehberi

![Ekran Resmi 2024-07-15 22 34 55](https://github.com/user-attachments/assets/3a366c1c-9002-492f-a023-4917f4b510af)

[Fractal Explorer](https://explorer.fractalbitcoin.io/)

### 1. Gerekli Paketlerin Kurulumu

- İşletim sistemi: **Ubuntu 22.04 ve üstü**

  ```shell
    apt update && apt upgrade -y
    apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
  ```

### 2. Fractal Reposunu Çekin
- Fractal reposunu indirin:
  ```shell
  screen -S node
  git clone https://github.com/fractal-bitcoin/fractald-release.git
  ```

### 3. Dizini Değiştirin
- İndirilen dizine gidin:
  ```shell
  cd /root/fractald-release/fractald-x86_64-linux-gnu
  ```

### 4. Data Adında Yeni Bir Klasör Oluşturun
- Yeni bir "data" klasörü oluşturun:
  ```shell
  mkdir data
  ```

### 5. Konfigürasyon Dosyasını Kopyalayın
- Konfigürasyon dosyasını "data" klasörüne kopyalayın:
  ```shell
  cp ./bitcoin.conf ./data
  ```

### 6. Node'u Başlatın
- Node'u başlatmak için şu komutu kullanın:
  ```shell
  ./bin/bitcoind -datadir=./data/ -maxtipage=504576000
  ```

**CTRL a d ile ayrılın.**

### 7. Cüzdan oluşturun
```shell
  cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
  ./bitcoin-wallet -wallet=CÜZDANADINIZIYAZIN create
  ```

Şimdilik bu kadar.. Kısa bir aranın ardından kaldığımız yerden devam..
