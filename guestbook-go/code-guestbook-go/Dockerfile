FROM golang:alpine AS build-env
RUN apk add --no-cache git
ADD . /src
RUN cd /src && go get -v -d && go build -o guestbook

# final stage
FROM alpine
#RUN apk add --no-cache curl
WORKDIR /app
ADD ./public/index.html /app/public/index.html
ADD ./public/script.js /app/public/script.js
ADD ./public/style.css /app/public/style.css
COPY --from=build-env /src/guestbook /app/
# HEALTHCHECK --interval=5s --retries=3 --timeout=5s CMD curl -f http://localhost:8080/healthz || exit 1
EXPOSE 3000
ENTRYPOINT ./guestbook