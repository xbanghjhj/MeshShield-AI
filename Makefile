.RECIPEPREFIX := >
.PHONY: fmt lint test build verify

fmt:
>gofmt -w cmd internal

lint:
>go vet ./...

test:
>go test ./...

build:
>mkdir -p bin
>go build -trimpath -o bin/meshshield-agent ./cmd/meshshield-agent
>go build -trimpath -o bin/meshshield-controller ./cmd/meshshield-controller

verify: lint test build