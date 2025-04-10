# CTF Community Challenge

## Prérequis
- Docker installé sur votre machine
- Les scripts de démarrage (`start_challenge.ps1` pour Windows ou `start_challenge.sh` pour Linux/macOS)
- Une connexion internet pour télécharger l'image

## Description
Un serveur tourne quelque part. Votre mission est de trouver le flag caché dans le monde virtuel.

## Comment jouer
1. Téléchargez l'image :
```bash
docker pull skoum/ctf_community_challenge_mc
```

2. Lancez le challenge :
- Sur Windows :
  - Si l'exécution de scripts est bloquée, utilisez :
  ```powershell
  powershell -ExecutionPolicy Bypass -File .\start_challenge.ps1
  ```
  - Sinon, exécutez simplement :
  ```powershell
  .\start_challenge.ps1
  ```
- Sur Linux/macOS :
```bash
chmod +x start_challenge.sh
./start_challenge.sh
```

3. Trouvez le serveur et explorez le monde virtuel.

## Note
Le flag est caché sous forme de QR code. Bonne chance !