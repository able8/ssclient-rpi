# ssclient-rpi
It starts one shadowsocks client with config file /dorry_data/kcpclient/shadowsocks.json on raspberrypi (arm7).

# How to use?
docker run -itd --privileged --restart=always --cap-add=NET_ADMIN --net=host -v /dorry_data/ssclient:/home/ssclient --name router_kcp dorrypizza/ssclient-rpi
