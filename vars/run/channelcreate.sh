#!/bin/bash
# Script to create channel block 0 and then create channel
cp $FABRIC_CFG_PATH/core.yaml /vars/core.yaml
cd /vars
export FABRIC_CFG_PATH=/vars
configtxgen -profile OrgChannel \
  -outputCreateChannelTx mychannel.tx -channelID mychannel

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=peer2.lr.ousl.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/lr.ousl.com/peers/peer2.lr.ousl.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=lr-ousl-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/msp
export ORDERER_ADDRESS=orderer1.ousl.com:7050
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/ousl.com/orderers/orderer1.ousl.com/tls/ca.crt
peer channel create -c mychannel -f mychannel.tx -o $ORDERER_ADDRESS \
  --cafile $ORDERER_TLS_CA --tls
