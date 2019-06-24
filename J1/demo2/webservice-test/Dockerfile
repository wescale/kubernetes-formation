FROM golang:1.8.1-onbuild
COPY . /go/src/app
RUN go get -d -v
RUN go install -v
CMD ["app"]
