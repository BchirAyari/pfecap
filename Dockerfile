# Use official node image as the base image
FROM node:latest AS build

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY package*.json ./

RUN npm install --prefer-offline --no-audit --progress=false

RUN npm install -g @angular/cli --prefer-offline --no-audit --progress=false

COPY . .

RUN echo "Avant la construction"
RUN npm run build --prod --verbose
RUN echo "Après la construction"

# Production stage
FROM nginx:alpine

# Copy the built files from the build stage
COPY --from=build /app/dist/capgimini /usr/share/nginx/html

# Expose port 80 (default for Nginx)
EXPOSE 80

# Démarrer le serveur Nginx
CMD ["nginx", "-g", "daemon off;"]
