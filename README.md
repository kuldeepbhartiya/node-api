# node-api

A sample RESTful API in Node.js, containerized for production and development with Podman or Docker Compose.

---

## Project Structure

```
my-node-api/
├── src/
│   ├── controllers/
│   ├── routes/
│   ├── config/
│   └── app.js
├── package.json
├── package-lock.json
├── Dockerfile
├── compose.yml
├── .env
└── run.sh
```

---

## API Endpoints

```bash
curl http://localhost:4000/api/health
curl http://localhost:4000/api/sayHello
curl http://localhost:4000/api/posts
```

---

## Containerization Overview

This project uses a multi-stage Dockerfile for production and debug builds. You can use Podman CLI, Podman Compose, or Docker Compose (with Podman Desktop) for local development and deployment.

---

## Prerequisites

- Windows 10/11
- Podman Desktop (with Docker Compose support) installed and running
- `.env` file with environment variables
- Docker CLI / Docker Compose CLI (optional, for Docker Compose usage)

---

## Dockerfile and compose.yml

The `Dockerfile` and `compose.yml` files are provided in the repository for reference. They define the build and service configuration for both production and development/debug environments.

---

## Usage

### 1. Podman CLI

- Build production image: `podman build -t node-api:latest --target base .`
- Run production container: `podman run -p 4000:4000 node-api:latest`
- Build debug image: `podman build -t node-api-debug:latest --target debug .`
- Run debug container interactively: `podman run -it -p 4000:4000 node-api-debug:latest`

---

### 2. Podman Compose

- Start production: `podman-compose --profile prod up --build`
- Start debug: `podman-compose --profile debug up --build`
- Enter debug container: `podman exec -it node-api-debug sh`

---

### 3. Docker Compose (with Podman Desktop)

- Configure Docker CLI to use Podman: `export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock`
- Start production: `docker-compose --profile prod up --build -d`
- Start debug: `docker-compose --profile debug up --build -d`
- Access debug container: `docker exec -it node-api-debug sh`
- Monitor logs: `docker-compose logs -f api` or `docker-compose logs -f api-debug`
- Stop containers: `docker-compose down`

---

## Hot Reload (Live Coding)

For development, the `api-debug` service mounts `./src` for live code editing. Use the debug profile with Compose.

---

## Using the Shell Script (`run.sh`)

- Make executable: `chmod +x run.sh`
- Run: `./run.sh`
- Stop containers: `docker-compose down`

---

## Deployment to AKS

- Build and push image:  
  `podman build -t node-api:latest .`  
  `podman tag node-api:latest <acr-name>.azurecr.io/node-api:latest`  
  `podman push <acr-name>.azurecr.io/node-api:latest`
- Deploy to AKS:  
  `kubectl apply -f k8s-deployment.yaml`

---

## Summary

- Local development: use `compose.yml` with Podman or Docker Compose.
- Production: build with Podman, deploy to AKS using Kubernetes manifests.

