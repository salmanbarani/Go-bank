DOCKER_POSTGRES_EXECUTE=docker exec -it postgres15
DB_NAME=go_bank

postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15.3-alpine3.18

createdb:
	$(DOCKER_POSTGRES_EXECUTE) createdb --username=root --owner=root $(DB_NAME)

dropdb:
	$(DOCKER_POSTGRES_EXECUTE) dropdb $(DB_NAME)


connectdb:
	$(DOCKER_POSTGRES_EXECUTE) psql $(DB_NAME)

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/go_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/go_bank?sslmode=disable" -verbose down

.PHONY: createdb migrateup migratedown