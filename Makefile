all: down up

up:
	docker-compose up --build --detach
	
down:
	docker-compose down --volumes --rmi local

logs:
	docker logs ceph-demo_ceph_1 -f

exec:
	docker exec -it ceph-demo_ceph_1 bash

kind-up:
	kind create cluster
	docker buildx build -t ceph-demo ./ceph-demo/
	kind load docker-image ceph-demo
	kubectl apply -f ./manifests/
	sleep 10
	kubectl  port-forward svc/ceph-demo 8080:8080 8443:8443 5000:5000 &

kind-down:
	kind delete cluster

.PHONY: all up down logs exec kind-up kind-down
