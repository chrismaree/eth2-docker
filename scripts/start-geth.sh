#!/bin/sh
# Starts a local fast-synced geth node.
#

DEFAULT_NETWORK=mainnet

if [ "$NETWORK" = "" ]; then
	NETWORK=$DEFAULT_NETWORK
fi

if [ "$ENABLE_METRICS" != "" ]; then
	METRICS_PARAMS="--metrics --pprof --pprof.addr 0.0.0.0"
fi


if [ "$START_GETH" != "" ]; then
	if [ "$NETWORK" != "$DEFAULT_NETWORK" ]; then
		exec geth --goerli --http --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --ipcdisable $METRICS_PARAMS
	else
		exec geth --http --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --ipcdisable $METRICS_PARAMS
	fi
fi