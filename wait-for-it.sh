#!/usr/bin/env bash
# wait-for-it.sh <host>:<port> -- <command...>
# Exemple: wait-for-it.sh db:3306 -- python manage.py runserver 0.0.0.0:8000

set -e

hostport=(${1//:/ })
host="${hostport[0]}"
port="${hostport[1]}"
shift
shift # retire le "--"

echo "⏳ Attente de la base de données ($host:$port)..."
until nc -z "$host" "$port"; do
  sleep 1
done

echo "✅ Base de données prête, lancement de la commande..."
exec "$@"
