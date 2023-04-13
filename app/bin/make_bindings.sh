#!/bin/bash

cd /app/somebindings
python -m venv .env
source .env/bin/activate
maturin develop
