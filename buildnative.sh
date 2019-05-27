#!/bin/bash
curl https://github.com/oracle/graal/releases/download/vm-19.0.0/graalvm-ce-linux-amd64-19.0.0.tar.gz -SL | tar -xzf -
pushd graalvm-ce-19.0.0
export JAVA_HOME=$(pwd)/
export PATH=$(pwd)/bin:$PATH
gu install native-image
sudo yum -y install zlib-devel
popd
git clone https://github.com/cstancu/micronaut-native-image.git
pushd micronaut-native-image/fresh-graal
./setup-native-image.sh
./build-native-image.sh
popd
git clone https://github.com/cstancu/netty-native-demo.git
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
cd netty-native-demo
mvn clean package
native-image --no-fallback --allow-incomplete-classpath -jar target/netty-svm-httpserver-full.jar -H:ReflectionConfigurationResources=netty_reflection_config.json -H:Name=netty-svm-http-server --initialize-at-build-time=io.netty,netty.svm --initialize-at-run-time=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http2.Http2CodecUtil,io.netty.handler.codec.http2.DefaultHttp2FrameWriter,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder -Dio.netty.noUnsafe=true
