#! /bin/bash

DEFAULT_TESTNET=medalla

# Set testnet name
if [ "$TESTNET" = "" ]; then
	TESTNET=$DEFAULT_TESTNET
fi

# Base dir
DATADIR=/root/.lighthouse/$TESTNET

WALLET_NAME=validators
WALLET_PASSFILE=$DATADIR/secrets/$WALLET_NAME.pass


if [ "$START_VALIDATOR" != "" ]; then
	if [ "$IMPORT_LAUNCHPAD_KEYSTORES" != "" ]; then
		echo $LAUNCHPAD_KEYSTORE_PASSWD | lighthouse \
			--delete-lockfiles \
                        --testnet $TESTNET \
			account validator import \
			--directory /root/validator_keys \
			--reuse-password \
			--stdin-inputs
	else
		if [ ! -d $DATADIR/secrets ]; then
			cd $DATADIR; mkdir secrets
		fi

		if [ ! -d $DATADIR/wallets ]; then
			lighthouse \
                                --delete-lockfiles \
				--debug-level $DEBUG_LEVEL \
				--testnet $TESTNET \
				account \
				wallet \
				create \
				--name $WALLET_NAME \
				--password-file $WALLET_PASSFILE
		else
			echo "Wallet directory already exists. Will not create wallet."
		fi

		lighthouse
                        --delete-lockfiles \
                        --debug-level $DEBUG_LEVEL \
			--testnet $TESTNET \
			account \
			validator \
			create \
			--wallet-name $WALLET_NAME \
			--wallet-password $WALLET_PASSFILE \
			--at-most $VALIDATOR_COUNT
	fi

	exec lighthouse \
                --delete-lockfiles \
		--debug-level $DEBUG_LEVEL \
		--testnet $TESTNET \
		validator \
		--beacon-node http://beacon_node:5052
fi
