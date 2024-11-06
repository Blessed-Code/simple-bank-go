# command untuk start container dari image postgres:12-alpine
postgres:
	docker run --name postgres12-test -p 8080:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

# ini command ketika kita udah masuk server postgres. createdb dst itu udah command dari postgres untuk buat db simple_bank
createdb:
	docker exec -it postgres12-test createdb --username=root --owner=root simple_bank

# ini juga sama kek createdb tapi untuk drop datbase simple_bank
dropdb:
	docker exec -it postgres12-test dropdb simple_bank

# command golang-migrate untuk jalanin script up yang ada di folder db/migration
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:8080/simple_bank?sslmode=disable" -verbose up

# sama kaya migrateup tapi untuk downnya
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:8080/simple_bank?sslmode=disable" -verbose down

sqlcgen:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlcgen test