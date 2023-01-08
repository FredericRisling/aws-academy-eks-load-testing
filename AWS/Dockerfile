FROM ubuntu:18.04
RUN echo "Installing Benchmark Dependencies"
RUN apt-get update
RUN apt install iperf -y
RUN apt install -y default-jre cmake sysbench docker.io && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean
CMD bin/bash