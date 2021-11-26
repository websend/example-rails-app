#!/bin/sh

# This is a busy loop we use to wait for the database to be ready when starting up in say Kubernetes.
until nc -z -v -w30 $DB_HOST $DB_PORT
do
  echo 'Waiting for Database...'
  sleep 1
done
echo "Database is up and running"
