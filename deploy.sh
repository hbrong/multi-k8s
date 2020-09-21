docker build -t hbrong/multi-client:latest -t hbrong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hbrong/multi-server:latest -t hbrong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hbrong/multi-worker:latest -t hbrong/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hbrong/multi-client:latest
docker push hbrong/multi-server:latest
docker push hbrong/multi-worker:latest

docker push hbrong/multi-client:$SHA
docker push hbrong/multi-server:$SHA
docker push hbrong/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hbrong/multi-server:$SHA
kubectl set image deployments/client-deployment client=hbrong/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hbrong/multi-worker:$SHA
