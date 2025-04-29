EXISTING_CONTAINER=$(docker ps -q --filter ancestor=skoum/ctf_community_challenge_web)
if [ ! -z "$EXISTING_CONTAINER" ]; then
    docker stop $EXISTING_CONTAINER
fi

docker run -d -p 5000:5000 skoum/ctf_community_challenge_web

echo "Le challenge a démarré sur http://localhost:5000. Bonne chance !"