# node-api
Sample restful api in node js

# Project Structure
```
my-node-api/
├── src/
│   ├── controllers/
│   │   ├── healthController.js
│   │   ├── helloController.js
│   │   └── publicApiController.js   <-- new
│   ├── routes/
│   │   └── apiRoutes.js
│   ├── config/
│   │   └── serverConfig.js
│   └── app.js
├── package.json
├── package-lock.json
├── Dockerfile
└── .env

```
# Endpoints usage
```
curl http://localhost:4000/api/health
curl http://localhost:4000/api/sayHello
curl http://localhost:4000/api/posts

```
# Node.js API with Podman (Multi-stage Build)

This section provides a RESTful Node.js API containerized with Podman, supporting **production** and **debug/development** builds via a multi-stage Dockerfile.

---

## Build & Run

### 1. Build Production Image
The production image is minimal and ready for deployment to **AKS (Linux)** or any container runtime.

```bash
podman build -t my-node-api:latest --target base .
```

## Run the container:
podman run -p 4000:4000 my-node-api:latest

## Test endpoint:
curl http://localhost:4000/api/health

2. Build Debug/Development Image
The debug image includes tools like curl, bash, and vim for troubleshooting inside the container.
```
podman build -t my-node-api:debug --target debug .

```
Run the container interactively:
```
podman run -it -p 4000:4000 my-node-api:debug

```
Inside the container:
curl http://localhost:4000/api/health

# Usage with Podman Compose
Start production (profile = prod)
```
podman-compose --profile prod up --build

Test: curl http://localhost:4000/api/health
```

Start debug (profile = debug)
```
podman-compose --profile debug up --build
```

Enter container:
```
podman exec -it node-api-debug sh

```
Inside Container:
```
curl http://localhost:4000/api/health
```

# Note:
You can also add hot reload (live coding) option in docker compose yaml for dev.
For podman compose, additional installation of linux distro is needed for local system only.

# Node.js API Development with Docker Compose CLI + Podman
This guide explains how to build, run, and debug your Node.js API locally using Docker Compose CLI with Podman Desktop on Windows.

It ensures lightweight setup, AKS-aligned Linux containers, and a consistent prod/debug workflow.

Prerequisites

Windows 10/11

Podman Desktop installed and running

Node.js application with multi-stage Dockerfile

.env file with environment variables

Docker CLI / Docker Compose CLI installed (standalone, ~20–30 MB)

1. Ensure Podman Desktop is running

Start podman-machine-default VM in Podman Desktop.

Make sure Docker API / Compose support is enabled in Podman Desktop settings.

2. Configure Docker CLI to use Podman socket

In bash terminal (Git Bash or WSL):
This guide explains how to build, run, and debug your Node.js API locally using Docker Compose CLI with Podman Desktop on Windows.

It ensures lightweight setup, AKS-aligned Linux containers, and a consistent prod/debug workflow.

Prerequisites

Windows 10/11

Podman Desktop installed and running

Node.js application with multi-stage Dockerfile

.env file with environment variables

Docker CLI / Docker Compose CLI installed (standalone, ~20–30 MB)

1. Ensure Podman Desktop is running

Start podman-machine-default VM in Podman Desktop.

Make sure Docker API / Compose support is enabled in Podman Desktop settings.

2. Configure Docker CLI to use Podman socket

In bash terminal (Git Bash or WSL):
# Point Docker CLI to Podman VM
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

Optional: add to .bashrc for persistence:
echo 'export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock' >> ~/.bashrc
source ~/.bashrc

3. Verify Docker CLI connectivity
docker info

Expected output:
Server:
  Name: podman
  ...

5. Build and Run Containers
Production Container
docker-compose --profile prod up --build -d

Debug Container
docker-compose --profile debug up --build -d

6. Verify API
# Production
curl http://localhost:4000/api/health

# Debug
curl http://localhost:4001/api/health

Logs can be monitored:
docker-compose logs -f api
docker-compose logs -f api-debug

7. Access Container Shell (Debug Only)
docker exec -it node-api-debug sh

Inside container:
curl http://localhost:4000/api/health

8. Stop Containers

docker-compose down

10. Optional: Persistent Docker Host
Add to your .bashrc or PowerShell profile for automatic setup:
# Bash / WSL
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

# PowerShell
$env:DOCKER_HOST="npipe:////./pipe/podman-machine-default"


# How to use it the Shellscript - run.sh
1. Make script executable (bash / WSL)
chmod +x run.sh

2. Run production container
./run.sh

4. Stop containers
docker-compose down

