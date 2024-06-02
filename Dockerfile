# Utilisation de l'image Node comme base
FROM node:latest AS build

# Définir le répertoire de travail
WORKDIR /usr/local/app

# Copier les fichiers du projet
COPY ./ /usr/local/app/

# Installer les dépendances du projet
RUN npm install

# Installer l'Angular CLI globalement
RUN npm install -g @angular/cli

# Générer le build de l'application
RUN npm run build

# Utilisation de l'image Nginx pour servir l'application
FROM nginx:latest

# Copier les fichiers de build dans le répertoire de Nginx
COPY --from=build /usr/local/app/dist /usr/share/nginx/html
