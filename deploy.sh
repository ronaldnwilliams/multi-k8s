docker build -t ronaldnwilliams/multi-client:latest -t ronaldnwilliams/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ronaldnwilliams/multi-server:latest -t ronaldnwilliams/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ronaldnwilliams/multi-worker -t ronaldnwilliams/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ronaldnwilliams/multi-client:latest
docker push ronaldnwilliams/multi-server:latest
docker push ronaldnwilliams/multi-worker:latest

docker push ronaldnwilliams/multi-client:$SHA
docker push ronaldnwilliams/multi-server:$SHA
docker push ronaldnwilliams/multi-worker:$SHA

kubectl apply -f k8s
kubectk set image deployments/server-deployment server=ronaldnwilliams/muti-server:$SHA
kubectk set image deployments/client-deployment server=ronaldnwilliams/muti-client:$SHA
kubectk set image deployments/worker-deployment server=ronaldnwilliams/muti-worker:$SHA
