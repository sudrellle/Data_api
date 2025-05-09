# Toujours spécifier une version de Python
FROM python:3.9

# Déclarer les arguments en haut
ARG DEV=false

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers requirements d'abord pour optimiser le cache
COPY ./requirement.txt /tmp/requirement.txt
COPY ./requirement.dev.txt /tmp/requirement.dev.txt

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    postgresql-client \
    build-essential \
    libpq-dev \
    && pip install --upgrade pip \
    && pip install -r /tmp/requirement.txt \
    && if [ "$DEV" = "true" ]; then pip install -r /tmp/requirement.dev.txt; fi \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /tmp/requirement.txt /tmp/requirement.dev.txt

# Créer un utilisateur non-root
RUN adduser \
    --disabled-password \
    --no-create-home \
    django-user

# Copier le code source de l'application
COPY . /app

# Configurer les variables d'environnement
ENV PYTHONUNBUFFERED=1

# Utiliser un utilisateur non-root
USER django-user

# Exposer le port
EXPOSE 8000


