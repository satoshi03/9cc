FROM alpine:3.8

RUN apk add --no-cache gcc libc-dev make bash

ADD . /home
WORKDIR /home

RUN make clean
RUN make test
