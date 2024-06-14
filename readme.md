# Docker based development environment

This repo has two main components that will allow to easily replicate a development environment for Bepple App.

- A `proxy-db` box that contains, well, a proxy (traefik.io) and a db (postgres with PostGIS extensions)
- A `dev-box` with all the requirements for a Bepple App dev environment

## Proxy and database box

The first time you run, we need docker to create an `external` network, so run:
```shell
# on the folder where you cloned this repo:
cd box
./first-run.sh
```
This starts couple of services used to develop your Rails app. 

- `db`: A postgres instance with the PostGIS extensions. Accessible from other containers at host db and from your local machine at localhost:5432
- http://proxy.dev.local: A [traefik](https://traefik.io) proxy instance for convenient networking between several local subdomains (i.e. app1.dev.local, db.dev.local, other.dev.local)
- http://docker.dev.local [Portainer](https://www.portainer.io) docker management UI

```
# add these convenient urls to your /etc/hosts file:
127.0.0.1    docker.dev.local
127.0.0.1    proxy.dev.local
```

## Requirements

You need to have [docker compose](https://docs.docker.com/compose/install/) installed on your computer

In the folder where you cloned the app, have an .env file like the sample one in ./dockerdev/.env

## Getting started

### Networking (subdomains)

The deployment task `bundle exec rake deployment:seed_tenants[2]` will create two tenants (you can pass N instead of 2 and get more tenants seeded); these tenants will have subdomains:

- t-0.dev.local
- t-1.dev.local
...
- t-N.dev.local  

To access each subdomain locally, the `proxy` service runs an instance of [traefik](https://traefik.io/) and the `app` container has docker `labels` that determine the routing rules (see `services.app.labels`). To be able to visit http://t-1.dev.local and see the local rails app, you need to add this to your `/etc/hosts`:
```
127.0.0.1    t-1.dev.local
127.0.0.1    t-2.dev.local
```

# Volumes

These volumes are created and used by docker-compose:

- .:/app:cached
- bundle:/usr/local/bundle
- node_modules:/app/node_modules
- packs:/app/public/packs
- postgis-data
- rails_cache:

# Logs

When you run a service, remove the `-d` (detached) flag and the logs will appear in the console:
```shell
docker-compose up app
```

If the containers are already running, use:
```shell
# get the name of the running containers
docker ps 
# follow (-f) a container logs
docker logs -f app_app_1
```

## Special notes for Apple silicon:
```shell
gem install libv8 -v '3.16.14.13' -- --with-system-v8
gem install therubyracer -- --with-v8-dir=/usr/local/opt/v8-315
```

