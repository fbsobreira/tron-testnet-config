#!/bin/bash

mkdir -p fullnode
mkdir -p soliditynode
# compile java-tron
cd java-tron
git checkout release
./gradlew build -x test
# copy to directories
if [ ! -f build/libs/FullNode.jar ]; then
    echo Something went wrong, please try to compile manually
    exit 1 # terminate and indicate error
fi
cp build/libs/FullNode.jar ../fullnode
cp build/libs/SolidityNode.jar ../soliditynode

cd ..
# Update WitnessKey
./update_witness.sh 

# update work.sh bin files
sed  "/JAR_FILE_PATH=/c\JAR_FILE_PATH=\"./fullnode/FullNode.jar\"" ./work.sh > ./work.sh.tmp && mv work.sh.tmp work.sh
sed  "/PID_FILE_PATH=/c\PID_FILE_PATH=\"java-tron-fullnode.pid\"" ./work.sh > ./work.sh.tmp && mv work.sh.tmp work.sh
sed  "/LOG_FILE_PATH=/c\LOG_FILE_PATH=\"java-tron-fullnode.log\"" ./work.sh > ./work.sh.tmp && mv work.sh.tmp work.sh
sed  "/CONF_FILE_PATH=/c\CONF_FILE_PATH=\"./config.conf\"" ./work.sh > ./work.sh.tmp && mv work.sh.tmp work.sh

# update work.sh bin files
sed  "/JAR_FILE_PATH=/c\JAR_FILE_PATH=\"./soliditynode/SolidityNode.jar\"" ./work.sh > ./work_solidity.sh.tmp && mv work_solidity.sh.tmp work_solidity.sh
sed  "/PID_FILE_PATH=/c\PID_FILE_PATH=\"java-tron-soliditynode.pid\"" ./work_solidity.sh > ./work_solidity.sh.tmp && mv work_solidity.sh.tmp work_solidity.sh
sed  "/LOG_FILE_PATH=/c\LOG_FILE_PATH=\"java-tron-soliditynode.log\"" ./work_solidity.sh > ./work_solidity.sh.tmp && mv work_solidity.sh.tmp work_solidity.sh
sed  "/CONF_FILE_PATH=/c\CONF_FILE_PATH=\"./config_solidity.conf\"" ./work_solidity.sh > ./work_solidity.sh.tmp && mv work_solidity.sh.tmp work_solidity.sh

chmod +x work.sh
chmod +x work_solidity.sh

echo All done! now start the server with \"./work.sh start\"
echo If you are planning to add a backup node, change the \"config.conf\" file prior run the start