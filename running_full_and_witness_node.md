
### First steps to run a Full Node and Witness Node in TRON's MAIN NET

- We will start from the premise that you already have a working server.
- You will need to decide which is the better specs for your server. For first tests will be good at least 4 CPU cores and 8GB of RAM (This is just for test, don't take this configuration to run a full node in production).
- Remember to open the firewall ports, the default ones are 18888 and 50051.

Tron’s network protocol has been implemented in java and can be found here: https://github.com/tronprotocol/java-tron 
To work with java-tron you will need ORALE JAVA 8, It will not work with previous or newer releases. So, to begin with you will need to update the system and install java 8. Here is the commands to do it in Ubuntu 16.04 LTS

```console
This will add the repository to APT list
# sudo add-apt-repository ppa:webupd8team/java
This will update the recent changes in the list and install JAVA 8
# sudo apt update; sudo apt install oracle-java8-installer
If you have another version of java installed, you will need to set the default to java 8
# sudo apt install oracle-java8-set-default
```

GIT? Do you need git? It will depends on how you choose to download the java-tron version. For production you might be using Release. So no, for development and tests, is easier to use git. I will explain using the release version.

Go to java-tron release repository: https://github.com/tronprotocol/java-tron/releases
Find the latest version, at this time is Odyssey-v2.0.4. Right click on Source code (tar.gz) and copy the link. Then go to the server again and download it using wget:

Attention: NO NEED TO USE SUDO or ROOT USER.
```console
# wget https://github.com/tronprotocol/java-tron/archive/Odyssey-v2.0.4.tar.gz 
Then uncompress the file using tar command: 
# tar -xzvf Odyssey-v2.0.4.tar.gz
```

This command will create a folder named java-tron-Odyssey-v2.0.4, the file name to untar and the folder will depend of which release version you downloaded.

To build java-tron, switch to the folder recently created and run the gradle build tool, like this:
```console
# cd java-tron-Odyssey-v2.0.4
# ./gradlew build
```

Same tests may fail due machine requirements or for another unknown reason. But usually the output java file is created under build/libs folder. So if you are a not a fan of the errors showing on screen, or just want to build it faster, try this one: 

This will build but skip test files 
```console
# ./gradlew build -x test
```

Now you have build the application and the output files are shown as follow over the build/libs directory:
```console
FullNode.jar
java-tron-1.0.0.jar
java-tron.jar
KeystoreFactory.jar
SolidityNode.jar
```

To run the full node, you can use FullNode.jar or java-tron.jar. You will also need a config file to specify the seed IPs and genesis block. Release and git already ships with this config file under /src/main/resource/config.conf. At the moment 06/23/2018, Tron MAIN Net is under severe rehearsal tests to be released on tht 25th. So the config file on repository does not match the current maintnet network. Its not a good ideia if you are starting now to use the mainnet. Try first tron's official testnet. Or out public testnet. Trons current testnet config file can be found here: https://github.com/tronprotocol/Documentation/blob/master/English_Documentation/TRON_Protocol/Test_Net_of_TRON.md

Next step you will need to create a directory and copy the java file and the config file to it. Following steps will do this supposing you still are under java-tron directory:
```console
# makdir ../fullnode
# cp build/libs/FullNode.jar ../fullnode/
# cp src/main/resources/config.conf ../fullnode/
```

Remember that you will need to adjust your config file as needed.
Now, switch to the directory created and run java-tron as you want, FullNode or Witness Node.
For a FullNode, you wont need a private key, so just type: 
```console
# cd../fullnode
# nohup java -jar FullNode.jar &
```
If you want to run a Witness node you will need a private key, the command is: 
```console
# cd../fullnode
# nohup java -jar FullNode.jar -p PRIVATE_KEY --witness &
```

The “nohup &” is to run the java-tron in background, and not output is given in the console, you will need to check if it is running through the logs, to it using the following command:
```console
# tail -f logs/tron.log 
```

This will show in your screen a lot of information, you can filter it using “GREP” as you need. Examples:  
```console
- Show the current head number in your node:
# tail -f logs/tron.log | grep -E “MyHead”
- Check if producing blocks on witness mode
# tail -f logs/tron.log | grep -A3 -E “Produce”
This last command will show “Try Produce Block” several times, and the follow output will indicate if the node is an elected witness, by given “It's not my turn” message. When the node finds his slot time, it will produce the block and broadcast to network, the message will be: “Produce block successfully, blockNumber: XXXXX....”
```
