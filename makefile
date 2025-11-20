dep:
	go mod tidy
	go mod vendor

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

