# Fractal Bitcoin Madenciliği Rehberi

Fractal Bitcoin Madenciliği Rehberi'ne hoş geldiniz. Bu depo, bir Fractal Bitcoin Node kurmak, bir Bitcoin adresi oluşturmak ve madencilik operasyonlarına başlamak için adım adım talimatlar içermektedir. Ayrıca, madencilik sürecinizi optimize etmek için bir madencilik havuzuna katılma kılavuzları da yer almaktadır.

## İçindekiler

1. [Gereksinimler](#gereksinimler)
2. [Adım 1: Fractal Bitcoin Node'unu Kurun](#adım-1-fractal-bitcoin-nodeunu-kurun)
3. [Adım 2: UniSat Cüzdanı ile Bir Bitcoin Adresi Oluşturun](#adım-2-unisat-cüzdanı-ile-bir-bitcoin-adresi-oluşturun)
4. [Adım 3: Madenciliğe Başlayın](#adım-3-madenciliğe-başlayın)
5. [Adım 4: Bir Madencilik Havuzuna Katılın](#adım-4-bir-madencilik-havuzuna-katılın)
6. [Faydalı Bağlantılar](#faydalı-bağlantılar)

## Gereksinimler

Başlamadan önce, aşağıdaki gereksinimlere sahip olduğunuzdan emin olun:

- Sabit internet bağlantısına sahip bir sunucu veya bilgisayar.
- Temel komut satırı işlemleri bilgisi.
- Yüklü Bitcoin Core yazılımı.

## Adım 1: Fractal Bitcoin Node'unu Kurun

Öncelikle, bir Fractal Bitcoin node'u kurmanız gerekmektedir. Aşağıdaki adımları izleyin:

1. Genellikle Bitcoin Core veri dizininde bulunan `bitcoin.conf` dosyasını açın.
2. Aşağıdaki yapılandırma ayarlarını ekleyin:

   ```bash
   rpcport=8332
   rpcuser=fractal
   rpcpassword=fractal_1234567
   ```

   Bu yapılandırma, node'unuzla etkileşime geçmenizi sağlayan RPC sunucusunu kurar.

## Adım 2: UniSat Cüzdanı ile Bir Bitcoin Adresi Oluşturun

Bitcoin madenciliği yapmak için ödülleri alabileceğiniz bir Bitcoin adresine ihtiyacınız var. Bu adresi UniSat cüzdanı kullanarak oluşturabilirsiniz. Yeni bir Bitcoin adresi oluşturmak için şu adımları izleyin:

1. UniSat cüzdanınızı açın.
2. Yeni bir Bitcoin adresi oluşturun. Adresin örnek formatı şu şekilde olabilir: `bc1qrcxxxxxxxxxxxxxxxxxxxxn772blw`.

## Adım 3: Madenciliğe Başlayın

Şimdi madenciliğe başlamaya hazırsınız. Fractal Bitcoin madenciliğine başlamak için aşağıdaki komutu kullanın:

```bash
./miner -o http://172.0.0.1:10332 -u fractal -p fractal_1234567 --coinbase-addr=bc1qrcxxxxxxxxxxxxxxxxxxxxn772blw -a sha256d -t 1 --no-longpoll
```

**Not:** Tek başına madencilik yapmak, yüksek zorluk seviyesi nedeniyle zorlayıcı olabilir. Daha iyi sonuçlar için bir madencilik havuzuna katılmanız önerilir.

## Adım 4: Bir Madencilik Havuzuna Katılın

Daha verimli madencilik yapmak için bir madencilik havuzuna katılmayı düşünebilirsiniz. Aşağıda, ViaBTC havuz yazılımını kullanarak birleştirilmiş ve izinsiz madencilik için örnek yapılandırmalar yer almaktadır.

### Birleştirilmiş Madencilik Yapılandırması:

```json
"main_coin": {
    "name": "BTC",
    "host": "192.168.1.10",
    "port": 8332,
    "user": "btc",
    "pass": "btc_xxxxxx"
},
"aux_coin": [
    {
        "name": "FB",
        "host": "192.168.1.11",
        "port": 8332,
        "user": "fractal",
        "pass": "fractal_1234567",
        "address": "bc1q1wxxxxxxxxxxxxx9mukymc"
    }
],
"aux_merkle_nonce": 0,
"aux_merkle_size": 16,
"aux_job_timeout": 10,
```

### İzinsiz Madencilik Yapılandırması:

```json
"main_coin": {
    "name": "FB",
    "host": "192.168.1.11",
    "port": 8332,
    "user": "fractal",
    "pass": "fractal_1234567"
},
"aux_coin": []
```

## Faydalı Bağlantılar

- [Fractal Mempool Explorer](https://mempool.fractalbitcoin.io/)
- [Fractal Bitcoin Explorer](https://explorer.fractalbitcoin.io/)
