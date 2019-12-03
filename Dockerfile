FROM cern/cc7-base

ARG BRANCH_OR_TAG=master
RUN env

RUN yum install -y wget bzip2 git \
  && yum install -y gcc \
  && yum install -y gcc-c++ \
  && yum install -y make \
  && cd / \
  && wget http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-9.1.0/gcc-9.1.0.tar.gz \
  && tar zxf gcc-9.1.0.tar.gz \
  && mv gcc-9.1.0 gcc \
  && cd /gcc \
  && ./contrib/download_prerequisites \
  && ./configure --disable-multilib --enable-languages=c,c++ \
  && make \
  && make install \
  && cd / \
  && rm -rf /gcc \
  && yum install -y cmake3 \
  && ln -s /bin/cmake3 /bin/cmake \
  && cd / \
  && git clone https://github.com/jbeder/yaml-cpp.git /yaml-cpp \
  && mkdir -p /yaml-cpp/build \
  && cd /yaml-cpp/build \
  && cmake .. && make && make install \
  && cd / \
  && rm -rf /yaml-cpp \
  && yum-config-manager --add-repo https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/CentOS_7/network:messaging:zeromq:release-stable.repo \
  && yum install -y cppzmq-devel \
  && git clone --depth=1 -b $BRANCH_OR_TAG -q https://github.com/google/googletest.git /googletest \
  && mkdir -p /googletest/build \
  && cd /googletest/build \
  && cmake .. && make && make install \
  && cd / \
  && rm -rf /googletest \
  && yum install -y doxygen \
  && yum remove -y wget bzip2 git \
  && yum install graphviz

RUN yum remove -y gcc gcc-c++

# Set Library Path
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/usr/local/lib64:/usr/lib64
