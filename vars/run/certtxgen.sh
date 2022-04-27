#!/bin/bash
cd $FABRIC_CFG_PATH
# cryptogen generate --config crypto-config.yaml --output keyfiles
configtxgen -profile OrdererGenesis -outputBlock genesis.block -channelID systemchannel

configtxgen -printOrg lr-ousl-com > JoinRequest_lr-ousl-com.json
configtxgen -printOrg notary-ousl-com > JoinRequest_notary-ousl-com.json
configtxgen -printOrg other-ousl-com > JoinRequest_other-ousl-com.json
configtxgen -printOrg rgd-ousl-com > JoinRequest_rgd-ousl-com.json
