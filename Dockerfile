FROM nervos/ckb-docker-builder:bionic-rust-1.41.0 as builder
LABEL maintainer="muxueqz <zhangmingyuan240@gmail.com>"

RUN git clone https://github.com/quake/ckb-indexer.git /ckb-indexer
RUN cd /ckb-indexer; \
    git checkout v0.1.6; \
    cargo build --release

FROM ubuntu:bionic
LABEL maintainer="muxueqz <zhangmingyuan240@gmail.com>"

## indexer port
EXPOSE 8116

COPY --from=builder /ckb-indexer/target/release/ckb-indexer /bin/ckb-indexer

ENV RUST_LOG=info
ENTRYPOINT ["/bin/ckb-indexer"]
#RUST_LOG=info ckb-indexer -s /data/indexer
