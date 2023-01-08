#!/bin/sh
echo "Starting benchmark ..."


# Installing Dependencies

sudo apt update
yes | sudo apt install sysbench
yes | sudo apt install docker.io
sudo apt install iperf

echo ""
echo "---------------Benchmarking-----------------"

# benchmark the disk read speed
sysbench --file-test-mode=seqrd fileio prepare > /dev/null 2>&1
DISK_READ=$(sysbench --file-test-mode=seqrd fileio run | grep 'read, MiB/s:')
sysbench --file-test-mode=seqwr fileio prepare > /dev/null 2>&1
DISK_WRITE=$(sysbench --file-test-mode=seqwr fileio run | grep 'written, MiB/s:')

CPU=$(sysbench cpu run | grep 'events per second:' | grep -oE '[^ ]+$')
MEMORY=$(sysbench memory run | grep 'transferred\|Total operations')
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock
GFLOPS=$(docker run -e LINPACK_ARRAY_SIZE=150 h20180061/linpack | grep % | grep -oE '[^ ]+$')

sysbench fileio --file-test-mode=seqwr prepare
FILEIO_SEQWR=$(sysbench fileio --file-test-mode=seqwr run | grep 'writes/s:\|fsyncs/s:\|written,\|of events:')
FILEIO_SEQRD=$(sysbench fileio --file-test-mode=seqrd run | grep 'reads/s:\|read,\|of events:')
FILEIO_SEQREWR=$(sysbench fileio --file-test-mode=seqrewr run | grep 'writes/s:\|fsyncs/s:\|written,\|of events:')
sysbench fileio --file-test-mode=seqrewr cleanup > /dev/null 2>&1
sysbench fileio --file-test-mode=seqwr cleanup > /dev/null 2>&1
sysbench fileio --file-test-mode=seqrd cleanup > /dev/null 2>&1


sysbench --test=fileio --file-test-mode=seqwr cleanup > /dev/null 2>&1

echo "-----CPU-------"
echo "cores: " $(getconf _NPROCESSORS_ONLN)
echo "CPU GFLOPS: " $GFLOPS
echo "CPU events/s: " $CPU
echo "-----Memory-------"
echo $MEMORY
echo "-----FILEIO-------"
echo "--rd--"
echo $FILEIO_SEQRD
echo "--wr--"
echo $FILEIO_SEQWR
echo "--rewr--"
echo $FILEIO_SEQREWR

echo "-----DISK-------"
echo "disk read: " $DISK_READ
echo "disk write: " $DISK_WRITE
echo "Done benchmarking"