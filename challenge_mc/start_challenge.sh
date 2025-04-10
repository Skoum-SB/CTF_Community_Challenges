# Arrêt des conteneurs existants (si ils existent)
EXISTING_CONTAINER=$(docker ps -q --filter ancestor=skoum/ctf_community_challenge_mc)
if [ ! -z "$EXISTING_CONTAINER" ]; then
    docker stop $EXISTING_CONTAINER
fi

# Lancement du serveur sur le port aléatoire
docker run -d -p 25565:25565 skoum/ctf_community_challenge_mc

# Affichage des informations
echo "Le challenge a démarré. Bonne chance !"