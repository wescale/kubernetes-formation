
docker build -t eu.gcr.io/slavayssiere-sandbox/api-test:0.0.3 .

docker run -it --name test-api -p8080:8080 eu.gcr.io/slavayssiere-sandbox/api-test:latest

docker rm -f $(docker ps -aq)

curl -X GET http://localhost:8080/
curl -X GET http://localhost:8080/ips

curl -X GET http://localhost:8080/facture
curl -X GET http://localhost:8080/client

curl -X PUT http://localhost:8080/hack/latency/1000

curl -H Host:webservice.docker.localhost -X POST -d '{ "path": "/tmp/health_KO" }' http://localhost:8080/hack/file
