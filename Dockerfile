########################################
# Stage 1: Base (production-ready)
########################################
FROM node:20-alpine AS base

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy source code and env file
COPY ./src ./src
COPY .env .env

# Expose port for API
EXPOSE 4000

# Define default startup command
CMD ["node", "src/app.js"]

# Health check (for Podman/Docker, but AKS will need probes in YAML later)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:4000/api/health || exit 1


########################################
# Stage 2: Debug (development/debugging only)
########################################
FROM base AS debug

# Install extra tools for troubleshooting
RUN apk add --no-cache curl bash vim

# Override CMD for interactive sessions
CMD ["sh"]
