#!/bin/bash
# Script to install chaincode onto a peer node
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=peer2.rgd.ousl.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/rgd.ousl.com/peers/peer2.rgd.ousl.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=rgd-ousl-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/rgd.ousl.com/users/Admin@rgd.ousl.com/msp
cd /go/src/github.com/chaincode/simple


if [ ! -f "simple_go_1.0.tar.gz" ]; then
  cd go
  GO111MODULE=on
  go mod vendor
  cd -
  peer lifecycle chaincode package simple_go_1.0.tar.gz \
    -p /go/src/github.com/chaincode/simple/go/ \
    --lang golang --label simple_1.0
fi

peer lifecycle chaincode install simple_go_1.0.tar.gz
