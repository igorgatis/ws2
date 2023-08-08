#!/bin/sh

set -e

cp $(tinygo env TINYGOROOT)/targets/wasm_exec.js docs/

tinygo build -o docs/ws2.wasm -target wasm ./main.go

