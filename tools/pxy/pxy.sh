#!/bin/bash -

if netcat -z localhost 8087 2>/dev/null;then
    export http_proxy=http://localhost:8087
    export https_proxy=http://localhost:8087
    curl http://localhost:8085/module/gae_proxy/control/download_cert |sudo tee  --append /usr/local/share/ca-certificates/goagent.crt
elif netcat -z host.docker.internal 8087 2>/dev/null
    ip=`/sbin/ip route|awk '/default/ { print $3 }'`
    export http_proxy=http://$ip:8087
    export https_proxy=http://$ip:8087
    curl http://$ip:8085/module/gae_proxy/control/download_cert |sudo tee  --append /usr/local/share/ca-certificates/goagent.crt
else
    export http_proxy=""
    export https_proxy=""
fi

starttime=`date +%s`
#执行程序
$*

endtime=`date +%s`
echo "use time： "$((endtime-starttime))"s"
unset http_proxy
unset https_proxy
