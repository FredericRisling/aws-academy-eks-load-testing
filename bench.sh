#!/bin/sh
echo "Starting benchmark ..."

sysbench --file-test-mode=seqrd fileio prepare
sysbench --file-test-mode=seqrd fileio run
