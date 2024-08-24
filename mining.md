# Fractal Bitcoin Mining Guide

Welcome to the Fractal Bitcoin Mining Guide. This repository contains step-by-step instructions for setting up a Fractal Bitcoin Node, creating a Bitcoin address, and starting mining operations. Additionally, it includes guidelines for joining a mining pool to optimize your mining process.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step 1: Set Up Fractal Bitcoin Node](#step-1-set-up-fractal-bitcoin-node)
3. [Step 2: Create a Bitcoin Address with UniSat Wallet](#step-2-create-a-bitcoin-address-with-unisat-wallet)
4. [Step 3: Start Mining](#step-3-start-mining)
5. [Step 4: Join a Mining Pool](#step-4-join-a-mining-pool)
6. [Useful Links](#useful-links)

## Prerequisites

Before you start, ensure you have the following:

- A server or a computer with a stable internet connection.
- Basic knowledge of command-line operations.
- Installed Bitcoin Core software.

## Step 1: Set Up Fractal Bitcoin Node

First, you need to set up a Fractal Bitcoin Node. Follow these steps:

1. Open the `bitcoin.conf` file, typically located in your Bitcoin Core data directory.
2. Add the following configuration settings:

   ```bash
   rpcport=8332
   rpcuser=fractal
   rpcpassword=fractal_1234567
   ```

   This configuration sets up the RPC server, which allows interaction with your node.

## Step 2: Create a Bitcoin Address with UniSat Wallet

To mine Bitcoin, you need a Bitcoin address to receive the rewards. You can create one using the UniSat wallet. Here's how to generate a new Bitcoin address:

1. Open your UniSat wallet.
2. Generate a new Bitcoin address. An example format for the address might look like: `bc1qrcxxxxxxxxxxxxxxxxxxxxn772blw`.

## Step 3: Start Mining

You are now ready to start mining. Use the following command to begin Fractal Bitcoin mining:

```bash
./miner -o http://172.0.0.1:10332 -u fractal -p fractal_1234567 --coinbase-addr=bc1qrcxxxxxxxxxxxxxxxxxxxxn772blw -a sha256d -t 1 --no-longpoll
```

**Note:** Solo mining can be challenging due to the high difficulty level. It's recommended to join a mining pool for better results.

## Step 4: Join a Mining Pool

For more efficient mining, consider joining a mining pool. Below are examples of how to integrate with ViaBTC pool software for merged and permissionless mining.

### Merged Mining Configuration:

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

### Permissionless Mining Configuration:

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

## Useful Links

- [Fractal Mempool Explorer](https://mempool.fractalbitcoin.io/)
- [Fractal Bitcoin Explorer](https://explorer.fractalbitcoin.io/)
