# Bitcoin Fractal Node Rehberi

### 1. Gerekli Paketlerin Kurulumu

- İşletim sistemi: **Ubuntu 24.04**

  ```sh
    apt update && apt upgrade -y
    apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
  ```

### 2. Fractal Reposunu GitHub'dan İndirin
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

### 4. Yeni Bir Klasör Oluşturun
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
  ./bitcoin-wallet -wallet=<cüzdan-adı> create
  ```

