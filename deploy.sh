docker build -t mitsaek/multi-client:latest -t mitsaek/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t mitsaek/multi-server:latest -t mitsake/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t mitsaek/multi-worker:latest -t mitsaek/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push mitsaek/multi-client:latest 
docker push mitsaek/multi-server:latest 
docker push mitsaek/multi-worker:latest

docker push mitsaek/multi-client:$SHA 
docker push mitsaek/multi-server:$SHA  
docker push mitsaek/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mitsaek/multi-server:$SHA 
kubectl set image deployments/client-deployment client=mitsaek/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=mitsaek/multi-worker:$SHA 

