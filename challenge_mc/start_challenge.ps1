$existingContainer = docker ps -q --filter ancestor=skoum/ctf_community_challenge_mc
if ($existingContainer) {
    docker stop $existingContainer
}

docker run -d -p 25565:25565 skoum/ctf_community_challenge_mc

Write-Host "Le challenge a démarré. Bonne chance !"