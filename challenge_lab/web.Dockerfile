FROM ubuntu:latest

# Mettre à jour et installer Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Supprimer l'ancien site Apache et copier ton site
RUN rm -rf /var/www/html/*
COPY public/ /var/www/html/

# Donner les bons droits aux fichiers
RUN chmod -R 644 /var/www/html/ && \
    find /var/www/html/ -type d -exec chmod 755 {} \;

# Exposer le port 80
EXPOSE 80

# Lancer Apache au démarrage
CMD ["apachectl", "-D", "FOREGROUND"]

