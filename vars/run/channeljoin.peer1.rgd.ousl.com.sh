#!/bin/bash
# Script to join a peer to a channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=peer1.rgd.ousl.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/rgd.ousl.com/peers/peer1.rgd.ousl.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=rgd-ousl-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/rgd.ousl.com/users/Admin@rgd.ousl.com/msp
export ORDERER_ADDRESS=orderer1.ousl.com:7050
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/ousl.com/orderers/orderer1.ousl.com/tls/ca.crt
if [ ! -f "mychannel.genesis.block" ]; then
  peer channel fetch oldest -o $ORDERER_ADDRESS --cafile $ORDERER_TLS_CA \
  --tls -c mychannel /vars/mychannel.genesis.block
fi

peer channel join -b /vars/mychannel.genesis.block \
  -o $ORDERER_ADDRESS --cafile $ORDERER_TLS_CA --tls
