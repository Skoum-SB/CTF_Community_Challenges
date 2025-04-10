# Arrêt des conteneurs existants (si ils existent)
$existingContainer = docker ps -q --filter ancestor=skoum/ctf_community_challenge_mc
if ($existingContainer) {
    docker stop $existingContainer
}

# Lancement du serveur sur le port aléatoire
docker run -d -p 25565:25565 skoum/ctf_community_challenge_mc

# Affichage des informations
Write-Host "Le challenge a démarré. Bonne chance !"