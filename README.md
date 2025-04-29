# CTF Community Challenge

## Prérequis
- Docker installé sur votre machine
- Les scripts de démarrage (`start_challenge.ps1` pour Windows ou `start_challenge.sh` pour Linux/macOS)
- Une connexion internet pour télécharger l'image

## Comment jouer

Lancez un challenge :
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