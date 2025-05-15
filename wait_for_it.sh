#!/usr/bin/env bash

set -e

host="$1"
shift
port="$1"
shift
cmd="$@"

echo "Attente du service $host:$port..."

until nc -z "$host" "$port"; do
  >&2 echo "Le service $host:$port n'est pas encore prêt - attente..."
  sleep 1
done

>&2 echo "Le service $host:$port est prêt - démarrage de l'application"
exec $cmd
