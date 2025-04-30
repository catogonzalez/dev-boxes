# Docker Based Development Environments

This repository provides basic proxy and database infrastructure for local development environments. It's intended to be used alongside the [multi-project development environment](https://github.com/catogonzalez/multi-project-dev-env) to create a complete development setup.

## Purpose

This repository provides:

1. A base infrastructure with:
   - A [Traefik](https://traefik.io) proxy for managing local domain routing
   - A Postgres database with pgvector extensions

## Requirements

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed on your computer

## Getting Started

### Step 1: Set up the base infrastructure

The first time you run, you need to create a Docker network and start the base services:

```shell
# From the root of the repository:
cd box
./fisrt-run.sh
```

This starts the following services:

- Traefik proxy: A reverse proxy for convenient networking between local subdomains
- PostgreSQL with pgvector: Database accessible at `localhost:5434` or `db.dev.local:5432` within the Docker network

Add these entries to your `/etc/hosts` file:
```
127.0.0.1    proxy.dev.local
127.0.0.1    db.dev.local
```

### Step 2: Using with multi-project development environment

After setting up the base infrastructure, you can use it with the [multi-project development environment](https://github.com/catogonzalez/multi-project-dev-env) which provides a standardized way to run multiple services simultaneously.

The multi-project environment will use:
- The shared Traefik proxy for routing
- The PostgreSQL database for data storage

This allows you to run multiple projects (API, Web, Mobile) seamlessly in a unified development environment without duplicating infrastructure services.

## Working with Containers

### Volumes

These Docker volumes are created to persist data:
- Database: `db_data`

### Networks

The proxy (and future containers) will communicate through the `traefik-public` docker network created when you run `./fisrt-run.sh`
