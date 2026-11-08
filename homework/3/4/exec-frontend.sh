docker run -d --name rikkei-frontend-qa -p 8082:8082 -e API_ENDPOINT=https://qa-api.rikkei.edu.vn nginx
docker exec -it rikkei-frontend-qa sh
echo $API_ENDPOINT