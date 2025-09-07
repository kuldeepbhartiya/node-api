#!/usr/bin/env bash
# run.sh - Build and run Node.js API with Podman Compose (or podman-compose)

# -------------------------------
# Configuration
# -------------------------------
PROFILE=${1:-prod}   # default to 'prod', pass 'debug' as argument
COMPOSE_FILE="compose.yml"

# -------------------------------
# Detect podman-compose command
# -------------------------------
if command -v "podman-compose" &> /dev/null; then
    COMPOSE_CMD="podman-compose"
elif podman compose version &> /dev/null; then
    COMPOSE_CMD="podman compose"
else
    echo "Neither 'podman compose' nor 'podman-compose' found. Please install Podman Compose."
    exit 1
fi

echo "Using compose command: $COMPOSE_CMD"
echo "Starting containers with profile: $PROFILE"

# -------------------------------
# Stop any existing containers
# -------------------------------
$COMPOSE_CMD -f $COMPOSE_FILE down

# -------------------------------
# Remove unused containers and images
# -------------------------------
echo "Removing unused containers and images..."
podman container prune -f
podman image prune -f

# -------------------------------
# Build and start containers
# -------------------------------
$COMPOSE_CMD -f $COMPOSE_FILE --profile $PROFILE up --build -d

# -------------------------------
# Tail logs
# -------------------------------
SERVICE_NAME="api"
if [ "$PROFILE" == "debug" ]; then
    SERVICE_NAME="api-debug"
fi

echo "Tailing logs for $SERVICE_NAME..."
$COMPOSE_CMD -f $COMPOSE_FILE logs -f $SERVICE_NAME
