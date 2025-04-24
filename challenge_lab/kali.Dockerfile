FROM kalilinux/kali-rolling

# Mise à jour et installation des paquets de base
RUN apt-get update && \
    apt-get install -y \
    kali-tools-top10 \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    iputils-ping \
    net-tools \
    curl \
    wget \
    vim \
    nano \
    nmap \
    hydra \
    john \
    unzip \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configuration de SSH
RUN mkdir -p /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Création de l'utilisateur Jason avec un mot de passe simple (password)
RUN useradd -m -s /bin/bash jason && \
    echo 'jason:password' | chpasswd && \
    adduser jason sudo && \
    echo 'jason ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Configuration du répertoire personnel de Jason et création du dossier protégé
RUN mkdir -p /home/jason/tools && \
    mkdir -p /home/jason/data && \
    mkdir -p /home/jason/secret_folder && \
    echo "Bravo tu as réussi ce challenge !!! J'espère qu'il était au niveau de tes attentes ! L'équipe CTF Community" > /home/jason/secret_folder/document.txt && \
    cd /home/jason && \
    zip -e -P "7hidkqsh901jdYnovCTF" protected_folder.zip secret_folder/document.txt && \
    rm -rf secret_folder && \
    chown -R jason:jason /home/jason

# Installation des outils supplémentaires pour CTF
RUN apt-get update && \
    apt-get install -y \
    wordlists \
    dirb \
    sqlmap \
    metasploit-framework \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ajout de la liste rockyou.txt décompressée
RUN mkdir -p /usr/share/wordlists && \
    gunzip -c /usr/share/wordlists/rockyou.txt.gz > /usr/share/wordlists/rockyou.txt || echo "rockyou.txt already decompressed"

# Exposition du port SSH
EXPOSE 22

# Démarrage du service SSH
CMD ["/usr/sbin/sshd", "-D"]