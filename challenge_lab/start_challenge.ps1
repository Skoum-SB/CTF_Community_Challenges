# Arrêter les conteneurs existants s'ils existent
$existingServices = docker ps -q --filter ancestor=skoum/ctf-lab-services
if ($existingServices) {
    docker stop $existingServices
}

$existingKali = docker ps -q --filter ancestor=skoum/ctf-lab-kali
if ($existingKali) {
    docker stop $existingKali
}

# Créer le réseau Docker s'il n'existe pas déjà
docker network inspect ctf-network > $null 2>&1
if (-not $?) {
    docker network create --subnet=172.20.0.0/24 ctf-network
}

# Lancer le conteneur de services CTF
docker run -d --name ctf-lab-services --network ctf-network --ip 172.20.0.2 -p 80:80 -p 21:21 -p 20:20 -p 21000-21010:21000-21010 -p 22:22 skoum/ctf-lab-services

# Lancer le conteneur Kali
docker run -d --name ctf-lab-kali --network ctf-network --ip 172.20.0.3 -p 1337:22 --cap-add NET_ADMIN --cap-add SYS_ADMIN skoum/ctf-lab-kali

Write-Host "Le challenge a démarré ! La machine Kali est accessible via SSH sur le port 1337. Bonne chance !"