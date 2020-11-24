#!/bin/sh
#
# Starts a local fast-synced geth node.

if [ "$START_GETH" != "" ]; then
	exec geth --http --http.addr "0.0.0.0" --http.vhosts=* --http.api "eth,net" --ipcdisable --nousb
fi
