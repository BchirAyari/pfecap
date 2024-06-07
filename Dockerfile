# Build stage
FROM node:latest AS build

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the application
RUN npm run build --prod

# Production stage
FROM nginx:alpine

# Copy the built files from the build stage
COPY --from=build /app/dist/angular-app /usr/share/nginx/html

# Expose port 80 (default for Nginx)
EXPOSE 80

# No CMD needed as Nginx will use its default configuration to serve files from /usr/share/nginx/html
