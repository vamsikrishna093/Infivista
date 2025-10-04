Infivista — Quick run & troubleshoot

A minimal guide to build and run the static site locally using Docker.

Prerequisites
- Docker Desktop installed and running (macOS)
- Terminal (zsh)

Build & run (exact commands used here)

Build the image (from repo root):

    docker build -t infivista:latest .

Run a persistent container (restarts automatically unless stopped):

    docker run -d --name infivista --restart unless-stopped -p 8080:80 infivista:latest

Temporary container (removed when stopped):

    docker run --rm -d -p 8080:80 --name infivista infivista:latest

Common commands

View logs:

    docker logs -f infivista

Stop / start:

    docker stop infivista
    docker start infivista

List containers and images:

    docker ps -a
    docker images

Quick checks

Verify site responds:

    curl -I http://localhost:8080

Inspect files inside image:

    docker run --rm -it infivista:latest /bin/sh -c "ls -la /usr/share/nginx/html"

Notes

- Submissions from the Schedule Demo form are stored in browser localStorage (client-side). To centralize requests, add a small backend endpoint.
- If you want, I can add `docker-compose.yml` or a small server to persist demo requests centrally.
