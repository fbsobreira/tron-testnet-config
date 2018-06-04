# Tron Testnet 

We are runnig a public testnet so the SR candidate could test the softwares update and new network topologies. If you need coins or votes, please contact me at tronfoundation.slack.com

To join the network:

```console
$ git clone https://github.com/tronprotocol/java-tron.git
$ cd java-tron
$ ./gradlew build
$ git clone https://github.com/fbsobreira/tron-testnet-config.git
$ cp build/libs/FullNode.jar tron-testnet-config/
$ cd tron-testnet-config
$ ./update_witness.sh
$ "Enter your node private key"
$ ./work.sh start
```
