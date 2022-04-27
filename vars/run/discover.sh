#!/bin/bash
# Script to discover endorsers and channel config
cd /vars

export PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/tls/ca.crt
export ADMINPRIVATEKEY=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/msp/keystore/priv_sk
export ADMINCERT=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/msp/signcerts/Admin@lr.ousl.com-cert.pem

discover endorsers --peerTLSCA $PEER_TLS_ROOTCERT_FILE \
  --userKey $ADMINPRIVATEKEY \
  --userCert $ADMINCERT \
  --MSP lr-ousl-com --channel mychannel \
  --server peer1.lr.ousl.com:7051 \
  --chaincode simple | jq '.[0]' | \
  jq 'del(.. | .Identity?)' | jq 'del(.. | .LedgerHeight?)' \
  > /vars/discover/mychannel_simple_endorsers.json

discover config --peerTLSCA $PEER_TLS_ROOTCERT_FILE \
  --userKey $ADMINPRIVATEKEY \
  --userCert $ADMINCERT \
  --MSP lr-ousl-com --channel mychannel \
  --server peer1.lr.ousl.com:7051 > /vars/discover/mychannel_config.json
