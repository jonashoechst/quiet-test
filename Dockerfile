FROM ubuntu

RUN apt-get update && \
    apt-get install -y build-essential cmake autoconf libjansson-dev libsndfile-dev

COPY libfec /root/libfec
WORKDIR /root/libfec
RUN ./configure
RUN make install

COPY liquid-dsp /root/liquid-dsp
WORKDIR /root/liquid-dsp
RUN ./bootstrap.sh
RUN ./configure
RUN make install

COPY quiet /usr/local/share/quiet
WORKDIR /usr/local/share/quiet
RUN ./bootstrap
ENV PATH $PATH:/usr/local/share/quiet/build/bin

WORKDIR /root/