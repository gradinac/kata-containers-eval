#!/bin/bash
curl https://github.com/oracle/graal/releases/download/vm-19.0.0/graalvm-ce-linux-amd64-19.0.0.tar.gz -SL | tar -xzf -
pushd graalvm-ce-19.0.0
export JAVA_HOME=$(pwd)/
export PATH=$(pwd)/bin:$PATH
gu install native-image
sudo yum -y install zlib-devel
popd
git clone https://github.com/cstancu/micronaut-native-image.git
cd micronaut-native-image/fresh-graal
./setup-native-image.sh
./build-native-image.sh
