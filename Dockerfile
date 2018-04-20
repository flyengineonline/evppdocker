FROM alpine
RUN apk update && apk upgrade && apk add --no-cache bash git libevent autoconf build-base automake libtool cmake boost-dev  \
 &&  apk --no-cache add ca-certificates \
 &&  wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glog/master/sgerrand.rsa.pub \
 &&  wget https://github.com/sgerrand/alpine-pkg-glog/releases/download/0.3.4-r0/glog-0.3.4-r0.apk \
 && wget https://github.com/sgerrand/alpine-pkg-glog/releases/download/0.3.4-r0/glog-dev-0.3.4-r0.apk \
&& apk --allow-untrusted add glog-0.3.4-r0.apk glog-dev-0.3.4-r0.apk \
&& git clone https://github.com/flyengineonline/evpp.git && cd evpp && git submodule update --init --recursive \
&& cd / && git clone https://github.com/gflags/gflags.git \
&& cd /gflags &&  mkdir -p build && cd build && pwd && cmake  .. && make && make install  \
&& cd /evpp &&  mkdir -p build && cd build && cmake  .. \
&& apk add libevent-dev gtest \
&& make -j3 \
&& rm -rf /evpp \
&& rm -rf /gflags \
&& rm /glog-0.3.4-r0.apk \
&& rm /glog-dev-0.3.4-r0.apk \
&& apk del bash git libevent autoconf build-base automake libtool cmake boost-dev
#CMD evpp/build/bin/example_httpecho


#EXPOSE 9009
