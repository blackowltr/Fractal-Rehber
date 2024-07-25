#!/bin/bash

echo -e ''
echo -e '\e[40m\e[92m'
echo ' ██████╗ ██╗      █████╗  ██████╗██╗  ██╗ ██████╗ ██╗    ██╗██╗'     
echo ' ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝██╔═══██╗██║    ██║██║'
echo ' ██████╔╝██║     ███████║██║     █████╔╝ ██║   ██║██║ █╗ ██║██║'    
echo ' ██╔══██╗██║     ██╔══██║██║     ██╔═██╗ ██║   ██║██║███╗██║██║'
echo ' ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗╚██████╔╝╚███╔███╔╝███████╗'
echo ' ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚══════╝'
echo -e '\e[0m'
echo ''

echo -e '\e[33mBlackOwl Farkıyla Fractal Bitcoin Node Kurulum Rehberine Hoş Geldiniz!\e[0m'

# Kurulum Başlatma Onayı
read -p "Kurulum işlemini başlatmak istiyor musunuz? (evet/hayır): " baslatma_cevap

if [ "$baslatma_cevap" != "evet" ]; then
  echo "Kurulum işlemi iptal edildi."
  exit 0
fi

# Paketlerin Kurulumu
echo -e '\e[33mPaketlerin Kurulumu\e[0m'
echo "Paketler kuruluyor... Lütfen bekleyin."
if ! sudo apt update && sudo apt upgrade -y; then
  echo "Paket güncelleme veya yükseltme işlemi başarısız oldu."
  exit 1
fi
if ! sudo apt install curl build-essential pkg-config libssl-dev git wget jq make gcc chrony -y; then
  echo "Gerekli paketlerin kurulumu başarısız oldu."
  exit 1
fi
echo "Paketler kuruldu."

# Fractal Reposunu Çekme
echo -e '\e[33mFractal Reposunu Çekme\e[0m'
echo "Fractal reposunu sunucumuza çekiyoruz..."
if ! git clone https://github.com/fractal-bitcoin/fractald-release.git; then
  echo "Fractal reposunun çekilmesi başarısız oldu."
  exit 1
fi
echo "Fractal reposu başarıyla sunucumuza çekildi."

# Dizine Gitme
echo -e '\e[33mDizine Gitme\e[0m'
cd /root/fractald-release/fractald-x86_64-linux-gnu || { echo "Dizin bulunamadı"; exit 1; }

# Data Klasörünü Oluşturma
echo -e '\e[33mData Klasörünü Oluşturma\e[0m'
echo "Data klasörünü oluşturuyoruz..."
if ! mkdir -p data; then
  echo "Data klasörünün oluşturulması başarısız oldu."
  exit 1
fi
echo "Data klasörü oluşturuldu."

# Konfigürasyon Dosyasını Kopyalama
echo -e '\e[33mKonfigürasyon Dosyasını Kopyalama\e[0m'
echo "Konfigürasyon dosyasını kopyalıyoruz..."
if ! cp ./bitcoin.conf ./data; then
  echo "Konfigürasyon dosyasının kopyalanması başarısız oldu."
  exit 1
fi
echo "Konfigürasyon dosyası kopyalandı."

# Servis Oluşturma
echo -e '\e[33mServis Oluşturma\e[0m'
echo "Servis dosyasını oluşturuyoruz..."
if ! tee /etc/systemd/system/fractald.service > /dev/null <<EOF
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
then
  echo "Servis dosyasının oluşturulması başarısız oldu."
  exit 1
fi

# Servisi Başlatma
echo -e '\e[33mServisi Başlatma\e[0m'
echo "Servisi başlatıyoruz..."
if ! sudo systemctl daemon-reload; then
  echo "Servis daemon yeniden yükleme başarısız oldu."
  exit 1
fi
if ! sudo systemctl enable fractald; then
  echo "Servis etkinleştirme başarısız oldu."
  exit 1
fi
if ! sudo systemctl start fractald; then
  echo "Servisin başlatılması başarısız oldu."
  exit 1
fi
echo "Servis başlatıldı."

# Log Kontrol
echo -e '\e[33mLog Kontrol\e[0m'
echo "Logları kontrol edebilirsiniz: sudo journalctl -u fractald -fo cat"

# Cüzdan Oluşturma
read -p "Cüzdan oluşturmak ister misiniz? (evet/hayır): " cevap

if [ "$cevap" == "evet" ]; then
  echo -e '\e[33mCüzdan Oluşturma\e[0m'
  echo "Cüzdan adını belirleyin:"
  read -p "Cüzdan adı: " CUZDAN

  # Cüzdan Adını Belirleme
  echo "export CUZDAN=\"$CUZDAN\"" >> $HOME/.bashrc
  source $HOME/.bashrc

  # Cüzdan Oluşturma Komutları
  echo "Cüzdan oluşturuluyor..."
  cd /root/fractald-release/fractald-x86_64-linux-gnu/bin
  if ! ./bitcoin-wallet -wallet="$CUZDAN" -legacy create; then
    echo "Cüzdan oluşturma başarısız oldu."
    exit 1
  fi
  echo "Cüzdan başarıyla oluşturuldu."

  # Cüzdan Yedeği Alma
  read -p "Cüzdan yedeğinizi almak ister misiniz? (evet/hayır): " yedek_cevap

  if [ "$yedek_cevap" == "evet" ]; then
    echo -e '\e[33mCüzdan Yedeği Alma\e[0m'
    echo "Cüzdan yedeğinizi alıyoruz..."
    if ! ./bitcoin-wallet -wallet=/root/.bitcoin/wallets/$CUZDAN/wallet.dat -dumpfile=/root/.bitcoin/wallets/$CUZDAN/MyPK.dat dump; then
      echo "Cüzdan yedeği alma işlemi başarısız oldu."
      exit 1
    fi
    cat /root/.bitcoin/wallets/$CUZDAN/MyPK.dat
    echo "Cüzdan yedeğiniz başarıyla alındı ve ekrana yazdırıldı."
  else
    echo "Cüzdan yedeği alma işlemi atlandı."
  fi
else
  echo "Cüzdan oluşturma işlemi atlandı."
fi

echo -e '\e[33mKurulumu Tamamlama\e[0m'
echo "Kurulumu tamamladınız. Logları kontrol edebilirsiniz: sudo journalctl -u fractald -fo cat"
echo "Herhangi bir sorun yaşarsanız destek için benimle iletişime geçin ve beni X'te takip etmeyi unutmayın. https://x.com/brsbtc"
