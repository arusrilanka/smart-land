#!/bin/bash
# Script to instantiate chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=peer2.lr.ousl.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/lr.ousl.com/peers/peer2.lr.ousl.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=lr-ousl-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/msp
export ORDERER_ADDRESS=orderer1.ousl.com:7050
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/ousl.com/orderers/orderer1.ousl.com/tls/ca.crt

peer chaincode invoke -o $ORDERER_ADDRESS --isInit \
  --cafile $ORDERER_TLS_CA --tls -C mychannel -n simple \
  --peerAddresses peer1.lr.ousl.com:7051 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/lr.ousl.com/peers/peer1.lr.ousl.com/tls/ca.crt \
  --peerAddresses peer2.notary.ousl.com:7051 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/notary.ousl.com/peers/peer2.notary.ousl.com/tls/ca.crt \
  --peerAddresses peer2.other.ousl.com:7051 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/other.ousl.com/peers/peer2.other.ousl.com/tls/ca.crt \
  --peerAddresses peer1.rgd.ousl.com:7051 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/rgd.ousl.com/peers/peer1.rgd.ousl.com/tls/ca.crt \
  -c '{"Args":[ "init","a","200","b","300" ]}' --waitForEvent
