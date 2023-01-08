#!/bin/sh
echo "Starting benchmark ..."

# benchmark the disk read speed
sysbench --file-test-mode=seqrd fileio prepare > /dev/null 2>&1
DISK_WRITE = $(sysbench --file-test-mode=seqrd fileio run)



