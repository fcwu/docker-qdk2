FROM ubuntu:14.04
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

# Install.
RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:chris-lea/node.js \
  && add-apt-repository -y ppa:fcwu-tw/ppa \
  && apt-get update \
  && apt-get install -y build-essential unzip curl wget git qdk2 realpath moreutils fakeroot \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ADD app.sh /
ENTRYPOINT ["/app.sh"]
