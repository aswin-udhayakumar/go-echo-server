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

# Docker build variables
ECR_REPO = 684154893900.dkr.ecr.us-east-1.amazonaws.com/1v-apigw-go-echo-server
ECR_TAG = master-latest
LOCAL_TAG = go-echo-server

docker-build:
	docker build -t $(LOCAL_TAG) .

docker-build-mac:
	docker buildx build --platform linux/amd64 -t $(LOCAL_TAG) .

docker-build-ecr:
	docker buildx build --platform linux/amd64 -t $(ECR_REPO):$(ECR_TAG) .

docker-push-ecr: docker-build-ecr
	docker push $(ECR_REPO):$(ECR_TAG)

docker-run: docker-build
	docker run -p 8080:8080 go-echo-server

docker-run-detached: docker-build
	docker run -d -p 8080:8080 --name echo-server go-echo-server

docker-stop:
	docker stop echo-server
	docker rm echo-server

docker-clean:
	docker rmi go-echo-server

