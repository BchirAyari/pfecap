# Use official node image as the base image
FROM node:alpine

# Set the working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Add the source code to app
COPY package*.json ./

RUN npm install -g @angular/cli@7.3.8 && \
    npm install --save-dev caniuse-lite@latest && \
    npm install && \
    npm update

COPY . .

# Construire l'application
RUN npm run build

# Expose port 4200
EXPOSE 4200

# Run the built application (production mode)
CMD ["ng", "serve", "--host", "0.0.0.0","--disable-host-check"]
