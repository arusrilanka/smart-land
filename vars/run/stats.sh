#!/bin/bash
# Script to check network status

let oked=0
let total=0
declare -a allpeernodes=(peer1.lr.ousl.com peer2.lr.ousl.com peer1.notary.ousl.com peer2.notary.ousl.com peer1.rgd.ousl.com peer2.rgd.ousl.com peer1.other.ousl.com peer2.other.ousl.com)
for anode in ${allpeernodes[@]}; do
  let total=1+$total
  ss=$(wget -O- -S ${anode}:7061/healthz | jq '.status')
  printf "%20s %s\n" $anode $ss
  if [ $ss == '"OK"' ]; then
    let oked=1+$oked
  fi
done

declare -a allorderernodes=(orderer1.ousl.com)
for anode in ${allorderernodes[@]}; do
  let total=1+$total
  ss=$(wget -O- -S ${anode}:7060/healthz | jq '.status')
  printf "%20s %s\n" $anode $ss
  if [ $ss == '"OK"' ]; then
    let oked=1+$oked
  fi
done

let percent=$oked*100/$total
echo "Network Status: $percent%"