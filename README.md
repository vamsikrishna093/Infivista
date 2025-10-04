Infivista — Run the static site in Docker

This repository contains a small static site (`index.html`) and an `nginx`-based `Dockerfile` to host it.

Goal
- Build an image locally
- Run the site in Docker Desktop
- Validate the site is serving correctly
- Learn basic container management commands

Prerequisites
- Docker Desktop installed on macOS and running
- A terminal (zsh) with access to the repository root

Quick commands (zsh)

# 1) Build the Docker image (from repo root)
# Replace `yourname/infivista` with a name you prefer
docker build -t yourname/infivista:latest .

# 2) Run the container, map port 8080 on the host to 80 in the container
docker run --rm -d -p 8080:80 --name infivista yourname/infivista:latest

# 3) Open in browser (macOS)
open http://localhost:8080

Validation commands

# Check running containers
docker ps

# View container logs
docker logs -f infivista

# Quick HTTP check using curl
curl -I http://localhost:8080

# If healthcheck is configured in the Dockerfile, inspect it
docker inspect --format='{{json .State.Health}}' infivista | jq

Stop / restart / update

# Stop
docker stop infivista

# Start (if previously run and stopped; if it was run with --rm you'll need to re-run)
docker start infivista

# Remove (if stopped)
docker rm infivista

# Rebuild (if you change files)
# Note: the trailing dot is the build context (the current directory). Omitting it causes the
# "requires 1 argument" error from buildx.
docker build -t yourname/infivista:latest .
# Then stop/remove old and run new image

docker run --rm -d -p 8080:80 --name infivista yourname/infivista:latest

Troubleshooting notes
- If you see 50x errors, `50x.html` is present and nginx will show its generic page.
- If index doesn't load, check `docker logs infivista` for nginx error messages.
- Verify files were copied into the image during build by running a temporary shell:
  docker run --rm -it yourname/infivista:latest /bin/sh
  ls -la /usr/share/nginx/html

Optional: docker-compose (create `docker-compose.yml`)

version: '3.8'
services:
  infivista:
    build: .
    image: yourname/infivista:latest
    ports:
      - "8080:80"
    restart: unless-stopped

Next steps & learning path
- Explore `docker run` flags (volumes, restart policies, env vars)
- Learn `docker-compose` for multi-service stacks (nginx + backend)
- Use `docker inspect` and `docker logs` for debug info

If you want, I can also:
- Add the `docker-compose.yml` file to the repo
- Run the build & run commands here and validate the container
- Add a tiny CI (GitHub Action) to build the image on push

Done: created `README.md` with commands and tips.
