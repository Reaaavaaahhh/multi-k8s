docker build -t reaaavaaahhh/multi-client:latest -t reaaavaaahhh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t reaaavaaahhh/multi-server:latest -t reaaavaaahhh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t reaaavaaahhh/multi-worker:latest -t reaaavaaahhh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push reaaavaaahhh/multi-client:latest
docker push reaaavaaahhh/multi-server:latest
docker push reaaavaaahhh/multi-worker:latest

docker push reaaavaaahhh/multi-client:$SHA
docker push reaaavaaahhh/multi-server:$SHA
docker push reaaavaaahhh/multi-worker:$SHA

kubectl apply -f client-cluster-ip-service.yaml
kubectl apply -f client-deployment.yaml
kubectl apply -f database-persistent-volume-claim.yaml
kubectl apply -f ingress-service.yaml
kubectl apply -f nginx-ingress-controller.yaml
kubectl apply -f postgres-cluster-ip-service.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f redis-cluster-ip-service.yaml
kubectl apply -f redis-deployment.yaml
kubectl apply -f server-cluster-ip-service.yaml
kubectl apply -f server-deployment.yaml
kubectl apply -f worker-deployment.yaml


kubectl set image deployments/server-deployment server=reaaavaaahhh/multi-server:$SHA --all
kubectl set image deployments/client/deployment client=reaaavaaahhh/multi-client:$SHA --all
kubectl set image deployments/worker/deployment worker=reaaavaaahhh/multi-worker:$SHA --all