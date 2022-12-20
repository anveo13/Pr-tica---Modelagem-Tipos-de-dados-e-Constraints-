CREATE TABLE states (
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE cities (
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50),
	"stateId" INTEGER REFERENCES states(id)
);

CREATE TABLE customers (
	id SERIAL NOT NULL PRIMARY KEY,
	"fullName" VARCHAR(50) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);

CREATE TABLE "customerPhones" (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	number VARCHAR(11) NOT NULL UNIQUE,
	type ENUM("landline","mobile") NOT NULL
);

CREATE TABLE "customerAddresses" (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	street TEXT NOT NULL,
	number TEXT NOT NULL UNIQUE,
	complement TEXT,
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" INTEGER REFERENCES cities(id)
);

CREATE TABLE "bankAccount" (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"accountNumber" TEXT NOT NULL,
	agency VARCHAR(6) NOT NULL ,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP
);

CREATE TABLE transactions (
	id SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id),
	amount DOUBLE PRECISION NOT NULL DEFAULT 0,
	type ENUM("deposit","withdraw") NOT NULL,
	"time" DATE NOT NULL,
	description TEXT NOT NULL,
	cancelled BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE "creditCards" (
	id SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id),
	name VARCHAR(30) NOT NULL,
	number TEXT NOT NULL,
	"securityCode" VARCHAR(4) NOT NULL,
	"expirationMonth" DATE NOT NULL,
	"expirationYear" DATE NOT NULL,
	password TEXT NOT NULL,
	limite INTEGER NOT NULL
);