docker build -t reaaavaaahhh/multi-client:latest -t reaaavaaahhh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t reaaavaaahhh/multi-server:latest -t reaaavaaahhh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t reaaavaaahhh/multi-worker:latest -t reaaavaaahhh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push reaaavaaahhh/multi-client:latest
docker push reaaavaaahhh/multi-server:latest
docker push reaaavaaahhh/multi-worker:latest

docker push reaaavaaahhh/multi-client:$SHA
docker push reaaavaaahhh/multi-server:$SHA
docker push reaaavaaahhh/multi-worker:$SHA

kubectl apply -f .
kubectl set image deployments/server-deployment server=reaaavaaahhh/multi-server:$SHA
kubectl set image deployments/client/deployment client=reaaavaaahhh/multi-client:$SHA
kubectl set image deployments/worker/deployment worker=reaaavaaahhh/multi-worker:$SHA