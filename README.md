# go-echo-server

A simple echo server written in Go using the Chi router framework. This server provides two main endpoints: a hello world endpoint and an echo endpoint that returns the request body.

## Features

- **Hello World Endpoint**: GET `/helloworld` - Returns a greeting message with a simple addition calculation
- **Echo Endpoint**: POST `/echo` - Echoes back the request body
- Built with [Chi](https://github.com/go-chi/chi) router framework
- Includes request logging middleware
- Docker support for containerized deployment

## Prerequisites

- Go 1.24.2 or higher
- Docker (for containerized deployment)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd go-echo-server
   ```

2. Install dependencies:
   ```bash
   make dep
   ```

## Usage

### Local Development

#### Build and Run
```bash
# Build the application
make build

# Run the application
make run

# Or build and run in one step
make run
```

The server will start on `http://localhost:8080`

#### Build for Linux
```bash
make build-linux
```

### Docker Deployment

#### Build and Run with Docker
```bash
# Build and run interactively
make docker-run

# Build and run in detached mode
make docker-run-detached

# Stop the container
make docker-stop

# Clean up Docker image
make docker-clean
```

## API Endpoints

### GET /helloworld
Returns a greeting message with a calculation result.

**Example:**
```bash
curl http://localhost:8080/helloworld
```

**Response:**
```
hello world, sum: 3
```

### POST /echo
Echoes back the request body.

**Example:**
```bash
curl -X POST http://localhost:8080/echo -d "Hello, Echo Server!"
```

**Response:**
```
Hello, Echo Server!
```

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make dep` | Install and vendor dependencies |
| `make build` | Build the application binary |
| `make build-linux` | Build for Linux (AMD64) |
| `make run` | Build and run the application |
| `make docker-build` | Build Docker image |
| `make docker-run` | Build and run with Docker (interactive) |
| `make docker-run-detached` | Build and run with Docker (detached) |
| `make docker-stop` | Stop and remove the Docker container |
| `make docker-clean` | Remove the Docker image |

## Project Structure

```
├── main.go              # Main application entry point
├── router/
│   └── router.go        # Router utilities and helper functions
├── go.mod               # Go module definition
├── makefile             # Build and deployment commands
├── Dockerfile           # Docker configuration
└── README.md            # This file
```

## Dependencies

- [Chi Router](https://github.com/go-chi/chi/v5) - Lightweight HTTP router for Go
