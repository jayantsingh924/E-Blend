# Stage 1: Build the Angular application
FROM node:lts-alpine as builder
WORKDIR /app

COPY . .
RUN npm install
RUN npm run build

# Stage 2: Serve the application using http-server
FROM node:lts-alpine
WORKDIR /app

# Install http-server globally
RUN npm install -g http-server

# Copy the built Angular application
COPY --from=builder /app/dist/e-blend /app

# Expose port 8080 (or your desired port)
EXPOSE 8080

# Start http-server
CMD ["http-server", "-p", "8080"]
