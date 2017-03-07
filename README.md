# ssclient-rpi
It is a docker images of shadowsocks ss-redir client build on raspberrypi 3 (arm7).

# Usage

* Fetch the code
```
git clone git@github.com:LaoLuMian/ssclient-rpi.git
```

* Modify the configuration
```
cd ssclient-rpi
vim shadowsocks.json
```


* Execute the ss-redir

You have 2 options
```
./ssclient_start.sh
```
or

```
sudo mkdir -p /dorry_data/ssclient_conf
sudo cp `pwd`/shadowsocks.json /dorry_data/ssclient_conf/ 
docker run -itd --privileged --restart=always --cap-add=NET_ADMIN --net=host -v /dorry_data/ssclient_conf:/home/ssclient --name router_ss ssclient-rpi:3.0.3
```
