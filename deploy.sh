docker build -t akrommusajid/multi-client:latest -t akrommusajid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akrommusajid/multi-server:latest -t akrommusajid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akrommusajid/multi-worker:latest -t akrommusajid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akrommusajid/multi-client:latest
docker push akrommusajid/multi-server:latest
docker push akrommusajid/multi-worker:latest
docker push akrommusajid/multi-client:$SHA
docker push akrommusajid/multi-server:$SHA
docker push akrommusajid/multi-worker:$SHA

kubectl apply -f ./complex/k8s
kubectl set image deployments/server-deployment server=akrommusajid/multi-server:$SHA
kubectl set image deployments/client-deployment client=akrommusajid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akrommusajid/multi-worker:$SHA
