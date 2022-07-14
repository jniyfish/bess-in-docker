FROM ubuntu:18.04

# Install updates and dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install \
        make \
        g++ \
        libsctp-dev \
        lksctp-tools \
        git \
        vim \
        iproute2 \
        iptables \
        net-tools \
        ifupdown \
        iputils-ping \
        wget \
        libssl-dev \
		curl \
		sudo \
        zlib*

RUN apt-get install linux-headers-$(uname -r) -y


# install python 2.7.15
RUN cd ~ && mkdir tmp && cd tmp
RUN wget https://www.python.org/ftp/python/2.7.15/Python-2.7.15.tgz
RUN tar zxvf Python-2.7.15.tgz  
RUN cd Python-2.7.15  && ./configure --prefix=$HOME/opt/python-2.7.15 --with-ensurepip=install && make && make install
RUN cd ~ && export PATH=$HOME/opt/python-2.7.15/bin:$PATH

# install bess
RUN cd ~ && git clone https://github.com/jniyfish/bar-bess.git

RUN  apt install make apt-transport-https ca-certificates g++ make pkg-config libunwind8-dev liblzma-dev zlib1g-dev libpcap-dev libssl-dev libnuma-dev git python python-pip python-scapy libgflags-dev libgoogle-glog-dev libgraph-easy-perl libgtest-dev libgrpc++-dev libprotobuf-dev libc-ares-dev libbenchmark-dev libgtest-dev protobuf-compiler-grpc -y

RUN pip install --upgrade pip
RUN pip install --user protobuf grpcio scapy
RUN cd ~/bar-bess && python ./build.py

#RUN git clone https://github.com/jniyfish/bar-bess.git
#RUN cd bar-bess
#RUN python ./build.py

RUN apt install tcpdump -y
RUN apt install pciutils kmod  -y
RUN apt install python3 -y
