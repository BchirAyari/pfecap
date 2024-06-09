# Build stage
FROM node:latest AS build

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY package*.json ./

# Install dependencies
RUN npm install --verbose

# Installer Angular CLI globalement
RUN npm install -g @angular/cli --verbose

# Copy the rest of the source code
COPY . .

# Build the application
RUN npm run build --prod --verbose

# Production stage
FROM nginx:alpine

# Copy the built files from the build stage
COPY --from=build /app/dist/capgimini /usr/share/nginx/html

# Expose port 80 (default for Nginx)
EXPOSE 80

# Démarrer le serveur Nginx
CMD ["nginx", "-g", "daemon off;"]
