#!/usr/bin/env bash

# update chn ip
wget -O- 'https://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) } /CN\|ipv6/ { printf("%s/%s\n", $4, $5) }' > ./chn.list.tmp

if [ $? -ne 0 ]; then
    rm -f ./chn.list.tmp
else
    rm -f ./chn.list
    mv ./chn.list.tmp ./chn.list
fi

# update chn domain
wget -O- 'https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf' | awk -F/ '/server=/ { printf("%s\n", $2) }' > ./chn_domain.list.tmp

if [ $? -ne 0 ]; then
    rm -f ./chn_domain.list.tmp
else
    rm -f ./chn_domain.list
    mv ./chn_domain.list.tmp ./chn_domain.list
fi