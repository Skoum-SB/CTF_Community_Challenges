EXISTING_CONTAINER=$(docker ps -q --filter ancestor=skoum/ctf_community_challenge_hydra)
if [ ! -z "$EXISTING_CONTAINER" ]; then
    docker stop $EXISTING_CONTAINER
fi

docker run -d -p 2222:22 skoum/ctf_community_challenge_hydra

echo "Le challenge a démarré sur le port 2222. Bonne chance !"