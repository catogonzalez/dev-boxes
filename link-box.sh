#!/bin/bash
ln -s ~/dev/dev-boxes/$1/box .
ln -s ~/dev/dev-boxes/$1/docker-compose.yml .
docker compose run --rm shell
