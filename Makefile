ssh-master:
	docker exec -it mongo_course_database_master /bin/bash
ssh-rs1:
	docker exec -it mongo_course_database_replica_1 /bin/bash
ssh-rs2:
	docker exec -it mongo_course_database_replica_2 /bin/bash
deploy:
	clear
	rm -rf docker/mongo/data
	docker-compose down
	docker-compose up --build -d