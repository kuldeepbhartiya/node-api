#!/usr/bin/env bash
# run.sh - Build and run Node.js API with Podman + Docker Compose

# -------------------------------
# Configuration
# -------------------------------
DOCKER_HOST=${DOCKER_HOST:-"unix:///run/user/$UID/podman/podman.sock"}
PROFILE=${1:-prod}   # default to 'prod', pass 'debug' as argument
COMPOSE_FILE="docker-compose.yml"

# -------------------------------
# Export Docker host for Podman socket
# -------------------------------
export DOCKER_HOST
echo "Using DOCKER_HOST=$DOCKER_HOST"
echo "Starting containers with profile: $PROFILE"

# -------------------------------
# Stop any existing containers
# -------------------------------
docker-compose -f $COMPOSE_FILE down

# -------------------------------
# Build and start containers
# -------------------------------
docker-compose -f $COMPOSE_FILE --profile $PROFILE up --build -d

# -------------------------------
# Tail logs
# -------------------------------
SERVICE_NAME="api"
if [ "$PROFILE" == "debug" ]; then
    SERVICE_NAME="api-debug"
fi

echo "Tailing logs for $SERVICE_NAME..."
docker-compose -f $COMPOSE_FILE logs -f $SERVICE_NAME
