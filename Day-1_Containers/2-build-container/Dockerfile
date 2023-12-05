# Start from a base image with Go installed
FROM golang:1.20-alpine

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the source from the go-app directory to the Working Directory inside the container
COPY go-app/ .

# Build the Go app
RUN go build -o main .

# Run the binary program produced by `go build`
CMD ["./main"]
