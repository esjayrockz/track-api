FROM golang:alpine

# Set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Set following work directory
WORKDIR /usr/local/bin/track

# Since the following 2 files do not change much, cache the module download step
COPY go.mod .
COPY go.sum .

# Download and install modules
RUN go mod download

# Copy the code now into the docker container
COPY ./ ./

# Build the code
RUN go build -o track-api

WORKDIR /usr/local/bin/track/dist

RUN cp /usr/local/bin/track/track-api .

# Run the server
CMD ["./track-api"]
