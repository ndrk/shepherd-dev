FROM cern/cc7-base

ARG BRANCH_OR_TAG=master
RUN env

#RUN yum -y update

RUN yum install -y wget

# Install GCC
RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y make
RUN wget http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-9.1.0/gcc-9.1.0.tar.gz
RUN tar zxf gcc-9.1.0.tar.gz
RUN mv gcc-9.1.0 gcc
RUN cd /gcc \
  && yum -y install bzip2 \
  && ./contrib/download_prerequisites \
  && ./configure --disable-multilib --enable-languages=c,c++ \
  && make \
  && make install
RUN rm -rf /gcc

# Install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4-Linux-x86_64.sh
RUN /bin/sh /cmake-3.14.4-Linux-x86_64.sh --skip-license
RUN rm cmake-3.14.4-Linux-x86_64.sh

# Install Yaml-CPP
RUN git clone https://github.com/jbeder/yaml-cpp.git /yaml-cpp
RUN mkdir -p /yaml-cpp/build
RUN cd /yaml-cpp/build \
  && cmake .. && make && make install
RUN rm -rf /yaml-cpp

# Install ZeroMQ
RUN yum-config-manager --add-repo http://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/CentOS_7/network:messaging:zeromq:release-stable.repo
#RUN wget https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/Release.key
#RUN apt-key add Release.key
#RUN apt-get install -q -y libzmq3-dev
RUN yum install -y libzmq3-dev

# Install Google Test
RUN git clone --depth=1 -b $BRANCH_OR_TAG -q https://github.com/google/googletest.git /googletest
RUN mkdir -p /googletest/build
RUN cd /googletest/build \
  && cmake .. && make && make install
RUN rm -rf /googletest

#RUN apt clean
