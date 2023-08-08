.PHONY: all serve

all: cmd/serve/serve docs/ws2.wasm

cmd/serve/serve: cmd/serve/main.go
	go build -o cmd/serve/serve cmd/serve/main.go

docs/ws2.wasm: main.go
	#GOARCH=wasm GOOS=js go build -o docs/ws2.wasm ./main.go
	docker run -it --rm \
		-v $$PWD:$$PWD -w $$PWD \
		--user=$$(id -u):$$(id -g) \
		tinygo/tinygo ./tinygo.sh

build-server: cmd/serve/serve

all-serve: cmd/serve/serve docs/ws2.wasm
		./cmd/serve/serve

serve: build-server
		./cmd/serve/serve

clean:
	rm -f cmd/serve/serve docs/ws2.wasm
