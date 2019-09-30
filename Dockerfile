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
RUN yum install -y cmake3
RUN ln -s /bin/cmake3 /bin/cmake

# Install git
RUN yum install -y git

# Install Yaml-CPP
WORKDIR /
RUN git clone https://github.com/jbeder/yaml-cpp.git /yaml-cpp \
  && mkdir -p /yaml-cpp/build \
  && cd /yaml-cpp/build \
  && cmake .. && make && make install \
  && rm -rf /yaml-cpp

# Install ZeroMQ
RUN yum-config-manager --add-repo https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/CentOS_7/network:messaging:zeromq:release-stable.repo
RUN yum install -y cppzmq-devel

# Install Google Test
RUN git clone --depth=1 -b $BRANCH_OR_TAG -q https://github.com/google/googletest.git /googletest
RUN mkdir -p /googletest/build
RUN cd /googletest/build \
  && cmake .. && make && make install
RUN rm -rf /googletest

# Install doxygen
RUN yum install -y doxygen

# Set Library Path
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/usr/local/lib64:/usr/lib64
