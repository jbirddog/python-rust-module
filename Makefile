DEV_SERVICE := dev

MY_USER := $(shell id -u)
MY_GROUP := $(shell id -g)
ME := $(MY_USER):$(MY_GROUP)

DO := docker compose run $(DEV_SERVICE)

.PHONY: all
all: dev-env

.PHONY: dev-env
dev-env:
	docker compose build --progress=plain $(DEV_SERVICE)

.PHONY: shell
shell:
	$(DO) /bin/bash

.PHONY: compile
compile:
	$(DO) cargo build --color=never

.PHONY: tests
tests:
	$(DO) cargo test --color=never

.PHONY: fmt
fmt:
	$(DO) cargo fmt

.PHONY: start
start:
	$(DO) cargo run --bin somebin

.PHONY: bindings
bindings:
	$(DO) /app/bin/make_bindings.sh

.PHONY: take-ownership
take-ownership:
	sudo chown -R $(ME) app

.PHONY: check-ownership
check-ownership:
	find . ! -user $(MY_USER) ! -group $(MY_GROUP)
