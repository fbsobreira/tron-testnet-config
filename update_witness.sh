#!/bin/bash
# Ask for PK
echo Please type node Private Key!
read PK

# repalce in file
sed  "/PRIVATE_KEY=/c\PRIVATE_KEY=\"${PK}\"" ./java-tron/work.sh > ./work.sh

