all: down up

up:
	docker-compose up --build --detach
	
down:
	docker-compose down --volumes --rmi local

logs:
	docker logs ceph-demo_ceph_1 -f

exec:
	docker exec -it ceph-demo_ceph_1 bash

.PHONY: all up down logs exec
