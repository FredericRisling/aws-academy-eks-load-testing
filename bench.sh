#!/bin/sh
echo "Starting benchmark ..."


# Installing Dependencies

apt update > /dev/null 2>&1
apt install default-jre sysbench docker.io iperf > /dev/null 2>&1


# benchmark the disk read speed
sysbench --file-test-mode=seqrd fileio prepare > /dev/null 2>&1
DISK_READ=$(sysbench --file-test-mode=seqrd fileio run | grep 'read, MiB/s:')
sysbench --file-test-mode=seqwr fileio prepare > /dev/null 2>&1
DISK_WRITE=$(sysbench --file-test-mode=seqwr fileio run | grep 'written, MiB/s:')


echo "disk read: " $DISK_READ
echo "disk write: " $DISK_WRITE
echo "Done benchmarking"



