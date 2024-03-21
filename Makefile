deploy:
	clear
	rm -rf docker/mongo/data
	docker-compose down
	docker-compose up --build -d
	sleep 10
	docker exec -it mongo_course_database mongosh --eval "rs.initiate()"