#!/bin/bash

# Arrêter les conteneurs existants s'ils existent
EXISTING_SERVICES=$(docker ps -q --filter ancestor=skoum/ctf-lab-services)
if [ ! -z "$EXISTING_SERVICES" ]; then
    docker stop $EXISTING_SERVICES
fi

EXISTING_KALI=$(docker ps -q --filter ancestor=skoum/ctf-lab-kali)
if [ ! -z "$EXISTING_KALI" ]; then
    docker stop $EXISTING_KALI
fi

# Créer le réseau Docker s'il n'existe pas déjà
if ! docker network inspect ctf-network &>/dev/null; then
    docker network create --subnet=172.20.0.0/24 ctf-network
fi

# Lancer le conteneur de services CTF
docker run -d --name ctf-lab-services --network ctf-network --ip 172.20.0.2 -p 80:80 -p 21:21 -p 20:20 -p 21000-21010:21000-21010 -p 22:22 skoum/ctf-lab-services

# Lancer le conteneur Kali
docker run -d --name ctf-lab-kali --network ctf-network --ip 172.20.0.3 -p 1337:22 --cap-add NET_ADMIN --cap-add SYS_ADMIN skoum/ctf-lab-kali

echo "Le challenge a démarré ! La machine Kali est accessible via SSH sur le port 1337. Bonne chance !"