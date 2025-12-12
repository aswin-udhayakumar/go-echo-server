# Build stage
FROM golang:1.24-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o go-echo-server main.go

# Final stage
FROM scratch

# Copy the binary from builder stage
COPY --from=builder /app/go-echo-server /go-echo-server

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["/go-echo-server"]