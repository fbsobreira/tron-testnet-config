# Tron Testnet 
This is a public testnet for testing softwares updates, network topologies, and failovers\
Join Telegram group at https://t.me/tronpublictestnet


### Dependencies
sudo apt-get update\
sudo apt-get upgrade

sudo add-apt-repository ppa:webupd8team/java\
sudo apt-get update\
sudo apt-get -y -V install oracle-java8-installer

### Java-Tron Build

```console
$ git clone https://github.com/tronprotocol/java-tron.git  
$ cd java-tron
$ ./gradlew build
$ git clone https://github.com/fbsobreira/tron-testnet-config.git  
$ cp build/libs/FullNode.jar tron-testnet-config/
$ cd tron-testnet-config
$ ./update_witness.sh 
<Enter your node private key>    
(If needed, you can get temp placeholder key at to tronscan.org)
$ ./work.sh start  
(start as Full node to begin syncing)
$ tail -F ~/java-tron/tron-testnet-config/logs/tron.log | grep -A5 -B2 "MyHeadBlockNum"
```  

### Start witness node
Use Wallet Operations below to register a TESTNET private key first
```console
$ cd java-tron/tron-testnet-config
$ ./work.sh stop
$ ./update_witness.sh 
<Enter your node private key>
$ ./work.sh start
```  
  
  
### Wallet Operations
> java-tron needs to be running for wallet actions
> Goto http://35.193.47.70:3000/#/nodes and confirm your node is listed and synced to highest block height

```console
$ git clone https://github.com/tronprotocol/wallet-cli.git
$ cd wallet-cli
$ cp src/main/resources/config.conf .
$ nano config.conf
(mem mainnet, un-mem testnet, change fullnode IP to 127.0.0.1)\
$ ./gradlew build
$ ./gradlew run -Pcmd
```  

##### Register wallet
```console
# run:
# RegisterWallet
<enter password of choice>
# Login <pw>
# GetAddress    (save address)
# BackupWallet  (save pk)
```  
> Request test TRX in Telegram group. Post wallet address and IP of synced node

##### Create Witness
```console
# run:
# Login
# GetBalance (confirm account balance > 0; balance shows TRX amount * 10^6)
# CreateWitness  <web url of choice>
Enter <y>; 
Enter <password>
# GetBalance  (confirm you have 9999000000 less)
# ListWitnesses  (confirm you are now on the list)
```  

> goto http://35.193.47.70:3000/#/representatives
> and confirm you are on the list

##### Vote
```console
# run:
# FreezeBalance xxxx000000 3   (Freeze is TRX amount * 10^6)
Enter <y>;
Enter <password>
# GetBalance  (confirm balance decreased)\
# VoteWitness <account address> xxxx  (xxxx is amount of TRX --- notTRX* 10^6)
Enter <y>;
Enter <password>
```  

> Goto http://35.193.47.70:3000/#/votes-live
> and confirm you have votes

Go back to instructions above and start node as witness
Wait for next 6 hour cycle to confirm you are producing blocks\
http://35.193.47.70:3000/#/representatives

**IF YOU FIND ANY INACCURACIES OR REQUIRED CLARIFICATIONS, PLEASE LET US KNOW IN TELEGRAM**
