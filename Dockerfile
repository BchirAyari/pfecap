# Use official node image as the base image
FROM node:latest

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY package*.json ./

RUN npm install

COPY . .

# Expose port 4200
EXPOSE 4200

# Démarrer l'application
CMD ["npm", "start"]
