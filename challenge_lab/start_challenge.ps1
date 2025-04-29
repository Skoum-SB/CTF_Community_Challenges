$existingContainer = docker ps -q --filter ancestor=skoum/ctf-lab-services
if ($existingContainer) {
    docker stop $existingContainer
}

docker run -d -p 80:80 -p 21:21 -p 20:20 -p 21000-21010:21000-21010 -p 22:22 skoum/ctf-lab-services

Write-Host "Le challenge a démarré. Bonne chance !"