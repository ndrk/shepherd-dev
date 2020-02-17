FROM cern/cc7-base:20191107 AS shepherd-build

ARG BRANCH_OR_TAG=master
RUN env

RUN yum install -y \
  boost-devel \
  bzip2 \
  cmake3 \
  doxygen \
  gcc \
  gcc-c++ \
  git \
  graphviz \
  log4cplus-devel \
  make \
  yaml-cpp-devel \
  wget

RUN ln -s /bin/cmake3 /bin/cmake

RUN yum-config-manager --add-repo https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/CentOS_7/network:messaging:zeromq:release-stable.repo \
  && yum install -y cppzmq-devel


RUN git clone --depth=1 -b release-1.10.0 -q https://github.com/google/googletest.git /googletest \
  && mkdir -p /googletest/build \
  && cd /googletest/build \
  && cmake .. && make && make install \
  && cd / \
  && rm -rf /googletest

#RUN yum remove -y \
#  bzip2 \
#  git \
#  wget

#RUN cd / \
#  && git clone https://github.com/jbeder/yaml-cpp.git /yaml-cpp \
#  && mkdir -p /yaml-cpp/build \
#  && cd /yaml-cpp/build \
#  && cmake .. && make && make install \
#  && cd / \
#  && rm -rf /yaml-cpp

RUN yum install -y \
  boost-devel \
  log4cplus-devel

# Set Library Path
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/usr/local/lib64:/usr/lib64


FROM cern/cc7-base:20191107 AS shepherd-dev

# Copy over compiled yaml-cpp Library

# Install zmq runtime
RUN yum-config-manager --add-repo https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/CentOS_7/network:messaging:zeromq:release-stable.repo \
  && yum install -y cppzmq-devel

# Set library path?
