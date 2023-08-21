.PHONY: all clean help serve

## make help
##   Shows this help.
##
help:
	@cat $(MAKEFILE_LIST) | sed -n -e 's/^##\s\?//p' | grep --color -E 'make.*|$$'

## make wasm
##   Builds WASM binary.
##
wasm: docs/ws2.wasm

## make serve
##   Builds server and WASM binary and starts serving.
##
serve: docs/ws2.wasm cmd/serve/serve
		./cmd/serve/serve

## make clean
##   Deletes build artifacts.
##
clean:
	rm -f cmd/serve/serve docs/ws2.wasm

cmd/serve/serve: cmd/serve/main.go
	go build -o cmd/serve/serve cmd/serve/main.go

docs/ws2.wasm: main.go
	#GOARCH=wasm GOOS=js go build -o docs/ws2.wasm ./main.go
	docker run -it --rm \
		-v $$PWD:$$PWD -w $$PWD \
		--user=$$(id -u):$$(id -g) \
		tinygo/tinygo ./tinygo.sh

