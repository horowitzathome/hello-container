FROM alpine:3.16.2 as builder

WORKDIR /opt/

RUN apk add curl protoc musl-dev gzip git

RUN curl -sLO https://github.com/horowitzathome/hello-container/releases/latest/download/hello-container-x86_64-unknown-linux-gnu.tar.gz \
  && tar -xvf hello-container-x86_64-unknown-linux-gnu.tar.gz \
  && chmod +x hello-container

############# Now create the image ##############

FROM gcr.io/distroless/static:nonroot

WORKDIR /opt

# Copy our build
COPY --from=builder /opt/hello-container /opt
EXPOSE 8081
CMD ["/opt/hello-container"]