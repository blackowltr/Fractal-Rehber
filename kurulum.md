Bitcoin Fractal Node'u Çalıştırma Kılavuzu

Teknik bilgi gerektirdiği için, Bitcoin Fractal Node'u bilgisayarınıza yerel olarak indirmeden önce sanal bir makine üzerinde çalıştırmanız önerilir.

### 1. Gerekli Paketlerin Kurulumu

- Ubuntu 24.04 işletim sistemi kurulmuş olmalıdır.

  ```sh
    apt update && apt upgrade -y
    apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y
  ```

### 2. Fractal Reposunu GitHub'dan İndirin
- Fractal reposunu indirin:
  ```sh
  git clone https://github.com/fractal-bitcoin/fractald-release.git
  ```

### 3. Dizini Değiştirin
- İndirilen dizine gidin:
  ```sh
  cd /root/fractald-release/fractald-x86_64-linux-gnu
  ```

### 4. Yeni Bir Klasör Oluşturun
- Yeni bir "data" klasörü oluşturun:
  ```sh
  mkdir data
  ```

### 5. Konfigürasyon Dosyasını Kopyalayın
- Konfigürasyon dosyasını "data" klasörüne kopyalayın:
  ```sh
  cp ./bitcoin.conf ./data
  ```

### 6. Node'u Başlatın
- Node'u başlatmak için şu komutu kullanın:
  ```sh
  ./bin/bitcoind -datadir=./data/ -maxtipage=504576000
  ```
