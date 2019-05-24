#!/bin/bash
cd kata-micronaut-native
cp ../micronaut-native-image/fresh-graal/fresh-graal image
sudo docker build -t katatest/nitest .
ts=$(date +%s%N)
echo "Running Micronaut server"
sudo docker run -p 8080:8080 katatest/nitest &
while true; do
	curl http://localhost:8080/hello/test &> /dev/null
	if [ $? -eq 0 ]; then
		break
	fi
	sleep 0.001
done
echo "Time taken:" $((($(date +%s%N) - $ts)/1000000)) "ms"
sudo killall containerd-shim
echo "Building netty server image"
cp ../netty-native-demo/netty-svm-http-server image
sudo docker build -t katatest/nitest .
echo "Running netty server"
ts=$(date +%s%N)
sudo docker run -p 8080:8080 katatest/nitest &
while true; do
	curl http://localhost:8080 &> /dev/null
	if [ $? -eq 0 ]; then
		break
	fi
	sleep 0.001
done
echo "Time taken:" $((($(date +%s%N) - $ts)/1000000)) "ms"
sudo killall containerd-shim
