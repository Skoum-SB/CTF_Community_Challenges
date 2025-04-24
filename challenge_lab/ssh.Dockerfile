FROM ubuntu:latest

# Installation des paquets nécessaires
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configuration de SSH
RUN mkdir /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Création des utilisateurs
RUN useradd -m -s /bin/bash adrien && \
    echo 'root:NVZi\$f4a' | chpasswd && \
    echo 'adrien:t9UJyAX&' | chpasswd

# Création du dossier caché .confidentiel et du fichier caché .levraiflag.txt
RUN mkdir -p /home/adrien/.confidentiel && \
    echo "Mot de passe du dossier de Jason à ne surtout pas divulguer !! 7hidkqsh901jdYnovCTF" > /home/adrien/.confidentiel/.levraiflag.txt && \
    chown -R adrien:adrien /home/adrien/.confidentiel

# Exposition du port SSH
EXPOSE 22

# Démarrage du service SSH
CMD ["/usr/sbin/sshd", "-D"]