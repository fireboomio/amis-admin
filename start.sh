#!/usr/bin/env bash
set -m

cd oidc && gzip -d oidc.gz
./oidc &
cd ../backend/custom-go && gzip -d fb-hook.gz
./fb-hook &
cd ../ && gzip -d fireboom.gz
./fireboom build && ./fireboom start
