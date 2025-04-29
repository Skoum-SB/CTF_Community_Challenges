$existingContainer = docker ps -q --filter ancestor=skoum/ctf_community_challenge_hydra
if ($existingContainer) {
    docker stop $existingContainer
}

docker run -d -p 2222:22 skoum/ctf_community_challenge_hydra

Write-Host "Le challenge a démarré sur le port 2222. Bonne chance !"