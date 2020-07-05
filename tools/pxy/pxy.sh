#!/bin/bash
export http_proxy=""
export https_proxy=""

if nmap localhost -p 39571 | grep open >/dev/null;then
    export http_proxy=http://localhost:39571
    export https_proxy=http://localhost:39571
elif nmap host.docker.internal -p 39571 | grep open >/dev/null;then
    ip=$(/sbin/ip route|awk '/default/ { print $3 }')
    export http_proxy=http://$ip:39571
    export https_proxy=http://$ip:39571
elif  nmap localhost -p 8087 | grep open >/dev/null;then
    export http_proxy=http://localhost:8087
    export https_proxy=http://localhost:8087
    curl http://localhost:8085/module/gae_proxy/control/download_cert |sudo tee  --append /usr/local/share/ca-certificates/goagent.crt
elif  nmap host.docker.internal -p 8087 | grep open >/dev/null;then
    ip=$(/sbin/ip route|awk '/default/ { print $3 }')
    if [ ! -f /usr/local/share/ca-certificates/goagent.crt ];then
        wget "http://$ip:8085/module/gae_proxy/control/download_cert" -O  /usr/local/share/ca-certificates/goagent.crt
        mkdir -p /usr/local/share/ca-certificates
        touch /usr/local/share/ca-certificates/goagent.crt
    fi
    export http_proxy=http://$ip:8087
    export https_proxy=http://$ip:8087
else
    export http_proxy=""
    export https_proxy=""
fi
starttime=$(date +%s)
#执行程序
"$@"
endtime=$(date +%s)
echo "use time： "$((endtime-starttime))"s"
unset http_proxy
unset https_proxy
