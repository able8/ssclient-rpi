sudo mkdir -p /dorry_data/ssclient_conf
sudo cp `pwd`/shadowsocks.json /dorry_data/ssclient_conf/ 
docker run -itd --privileged --restart=always --cap-add=NET_ADMIN --net=host -v /dorry_data/ssclient_conf:/home/ssclient --name router_ss ssclient-rpi:test
