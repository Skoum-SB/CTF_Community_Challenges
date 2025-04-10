# Utilisation d'une image de base Ubuntu
FROM ubuntu:latest

# Installation de Hydra et des utilitaires nécessaires
RUN apt update && apt install -y hydra openssh-server && \
    mkdir /var/run/sshd

# Création d'un utilisateur "agent" avec un mot de passe faible
RUN useradd -m -s /bin/bash agent74 && \
    echo "agent74:password123" | chpasswd

# Création du flag dans le home de l'utilisateur
RUN echo "FLAG{weak_password}" > /home/agent74/secret_flag.txt && \
    chown agent74:agent74 /home/agent74/secret_flag.txt

# Exposition du port SSH
EXPOSE 22

# Lancement du service SSH
CMD ["/usr/sbin/sshd", "-D"]
