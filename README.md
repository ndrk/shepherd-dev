# shepherddev Docker Images

## shepherddev_build
- Cern CentOS 7 with ZMQ, Google Test, GCC 9 and other packages.
- Used to compile code.

## shepherddev_run
- Cern CentOS 7 with ZMQ.
- Used to run code during development cycle.

## Getting Pre-Build Images
`docker pull rknowlton/shepherddev_build` \
`docker pull rknowlton/shepherddev_run`

## Building the Images
- [Install Docker](https://docs.docker.com/install/)
- Clone this repository
- cd *repo_dir*
- `docker build .`

## Usage
- `docker run -t -v `pwd`:/usr/src -w /usr/src/ rknowlton/shepherddev_build make all`
- `docker run -t -v `` `pwd` ``:/usr/src -w /usr/src/ rknowlton/shepherddev_build ./bin/application`
