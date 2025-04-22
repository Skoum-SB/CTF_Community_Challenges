# Utiliser l'image Python officielle
FROM python:3.9-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de l'application
COPY app /app

# Installer les dépendances
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Exposer le port utilisé par Flask
EXPOSE 5000

# Commande pour lancer l'application Flask
CMD ["python", "app.py"]
