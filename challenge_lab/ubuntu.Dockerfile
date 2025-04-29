FROM ubuntu:latest

# Installation des paquets nécessaires
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    vsftpd \
    openssh-server \
    zip \
    supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configuration Apache
RUN rm -rf /var/www/html/*

# Configuration SSH
RUN mkdir -p /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Création des utilisateurs SSH
RUN useradd -m -s /bin/bash adrien && \
    echo 'root:NVZi\$f4a' | chpasswd && \
    echo 'adrien:t9UJyAX&' | chpasswd

# Création du dossier caché .confidentiel et du fichier caché .levraiflag.txt
RUN mkdir -p /home/adrien/.confidentiel && \
    echo "Mot de passe du dossier de Jason à ne surtout pas divulguer !! 7hidkqsh901jdYnovCTF" > /home/adrien/.confidentiel/.levraiflag.txt && \
    chown -R adrien:adrien /home/adrien/.confidentiel

# Configuration FTP
# Création de l'arborescence FTP
RUN mkdir -p /var/ftp/home/administration/rh/personnel/directeur_adrien && \
    mkdir -p /var/ftp/home/communication && \
    mkdir -p /var/ftp/home/publics && \
    mkdir -p /var/ftp/home/étudiants && \
    mkdir -p /var/ftp/home/informatique

# Création du fichier note.txt et du ZIP protégé
RUN echo "Bonjour Adrien, voici ton mot de passe pour te connecter à la machine : t9UJyAX&" > /var/ftp/home/administration/rh/personnel/directeur_adrien/note.txt && \
    cd /var/ftp/home/administration/rh/personnel/directeur_adrien && \
    zip -P password123 compte_ssh.zip note.txt && \
    rm note.txt

# Attribution des permissions
RUN chmod -R 555 /var/ftp

# Créer le répertoire chroot manquant
RUN mkdir -p /var/run/vsftpd/empty

# Configuration de vsftpd
RUN echo "listen=YES" > /etc/vsftpd.conf && \
    echo "anonymous_enable=YES" >> /etc/vsftpd.conf && \
    echo "local_enable=YES" >> /etc/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "local_umask=022" >> /etc/vsftpd.conf && \
    echo "anon_upload_enable=NO" >> /etc/vsftpd.conf && \
    echo "anon_mkdir_write_enable=NO" >> /etc/vsftpd.conf && \
    echo "dirmessage_enable=YES" >> /etc/vsftpd.conf && \
    echo "use_localtime=YES" >> /etc/vsftpd.conf && \
    echo "xferlog_enable=YES" >> /etc/vsftpd.conf && \
    echo "connect_from_port_20=YES" >> /etc/vsftpd.conf && \
    echo "chown_uploads=NO" >> /etc/vsftpd.conf && \
    echo "secure_chroot_dir=/var/run/vsftpd/empty" >> /etc/vsftpd.conf && \
    echo "ftpd_banner=Bienvenue sur le serveur FTP du CTF" >> /etc/vsftpd.conf && \
    echo "pasv_enable=YES" >> /etc/vsftpd.conf && \
    echo "pasv_min_port=21000" >> /etc/vsftpd.conf && \
    echo "pasv_max_port=21010" >> /etc/vsftpd.conf && \
    echo "anon_root=/var/ftp" >> /etc/vsftpd.conf && \
    echo "no_anon_password=YES" >> /etc/vsftpd.conf

# Configuration de supervisor pour gérer les trois services
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exposer les ports nécessaires
EXPOSE 80 20 21 21000-21010 22

# Lancer supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]