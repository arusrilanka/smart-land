#!/bin/bash
# Script to approve chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=peer2.lr.ousl.com:7051
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/lr.ousl.com/peers/peer2.lr.ousl.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=lr-ousl-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/msp
export ORDERER_ADDRESS=orderer1.ousl.com:7050
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/ousl.com/orderers/orderer1.ousl.com/tls/ca.crt

peer lifecycle chaincode queryinstalled -O json | jq -r '.installed_chaincodes | .[] | select(.package_id|startswith("simple_1.0:"))' > ccstatus.json

PKID=$(jq '.package_id' ccstatus.json | xargs)
REF=$(jq '.references.mychannel' ccstatus.json)

SID=$(peer lifecycle chaincode querycommitted -C mychannel -O json \
  | jq -r '.chaincode_definitions|.[]|select(.name=="simple")|.sequence' || true)
if [[ -z $SID ]]; then
  SEQUENCE=1
elif [[ -z $REF ]]; then
  SEQUENCE=$SID
else
  SEQUENCE=$((1+$SID))
fi


export CORE_PEER_LOCALMSPID=lr-ousl-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/lr.ousl.com/peers/peer1.lr.ousl.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/lr.ousl.com/users/Admin@lr.ousl.com/msp
export CORE_PEER_ADDRESS=peer1.lr.ousl.com:7051

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.lr-ousl-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=notary-ousl-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/notary.ousl.com/peers/peer1.notary.ousl.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/notary.ousl.com/users/Admin@notary.ousl.com/msp
export CORE_PEER_ADDRESS=peer1.notary.ousl.com:7051

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.notary-ousl-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=other-ousl-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/other.ousl.com/peers/peer1.other.ousl.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/other.ousl.com/users/Admin@other.ousl.com/msp
export CORE_PEER_ADDRESS=peer1.other.ousl.com:7051

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.other-ousl-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=rgd-ousl-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/rgd.ousl.com/peers/peer2.rgd.ousl.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/rgd.ousl.com/users/Admin@rgd.ousl.com/msp
export CORE_PEER_ADDRESS=peer2.rgd.ousl.com:7051

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.rgd-ousl-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi
