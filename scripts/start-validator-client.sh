#! /bin/bash

DEFAULT_NETWORK=mainnet

# Set testnet name
if [ "$NETWORK" = "" ]; then
	NETWORK=$DEFAULT_NETWORK
fi

if [ "$ENABLE_METRICS" != "" ]; then
	METRICS_PARAMS="--metrics --metrics-address 0.0.0.0 "
fi

if [ "$START_VALIDATOR" != "" ]; then
	exec lighthouse \
		--debug-level $DEBUG_LEVEL \
		--network $NETWORK \
		validator \
                $METRICS_PARAMS \
		--beacon-node http://beacon_node:5052
fi
