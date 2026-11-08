docker run -d --name rikkei-db -p 5432:5432 -e POSTGRES_PASSWORD=Rikkei@2026 -v /opt/rikkei/pg-data:/var/lib/postgresql/data postgres:16
docker rm -f rikkei-db
sudo ls -l pg-data/