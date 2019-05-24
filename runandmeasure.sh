#!/bin/bash
cd kata-micronaut-native
cp ../micronaut-native-image/fresh-graal/fresh-graal .
sudo docker build -t katatest/nitest .
ts=$(date +%s%N)
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
