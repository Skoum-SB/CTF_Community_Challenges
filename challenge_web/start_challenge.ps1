$existingContainer = docker ps -q --filter ancestor=skoum/ctf_community_challenge_web
if ($existingContainer) {
    docker stop $existingContainer
}

docker run -d -p 5000:5000 skoum/ctf_community_challenge_web

Write-Host "Le challenge a démarré sur http://localhost:5000. Bonne chance !"