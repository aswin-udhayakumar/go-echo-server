dep:
	go mod tidy
	go mod vendor

lint:
	@which golangci-lint > /dev/null || (echo "golangci-lint not found, installing..." && make lint-install)
	golangci-lint run ./...

lint-install:
	@echo "Installing golangci-lint..."
	@which brew > /dev/null && brew install golangci-lint || \
		(curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin)

fmt:
	go fmt ./...

unit-test:
	go test -cover ./... -v

build:
	go build -o go-echo-server main.go 

build-linux:
	GOOS=linux GOARCH=amd64 go build -o main-linux main.go

run: build
	./go-echo-server

docker-build:
	docker build -t go-echo-server .

docker-run: docker-build
	docker run -p 8080:8080 go-echo-server

docker-run-detached: docker-build
	docker run -d -p 8080:8080 --name echo-server go-echo-server

docker-stop:
	docker stop echo-server
	docker rm echo-server

docker-clean:
	docker rmi go-echo-server

