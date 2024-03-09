deploy:
	clear
	rm -rf docker/mongo/data
	docker-compose down
	docker-compose up --build -d
