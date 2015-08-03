BEGIN;

CREATE DATABASE IF NOT EXISTS mail
  DEFAULT CHARACTER SET 'utf8';

USE mail;

DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS aliases;

CREATE TABLE IF NOT EXISTS domains (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  domain VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE(domain)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  domain BIGINT UNSIGNED REFERENCES domains(id),
  email VARCHAR(128) NOT NULL,
  password VARCHAR(128) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (email)
) DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS aliases (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  domain BIGINT UNSIGNED REFERENCES domains(id),
  source VARCHAR(128) REFERENCES users(email),
  dest VARCHAR(128) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (source)
) DEFAULT CHARSET=utf8;

INSERT INTO domains (domain) VALUES
  ('waffles4.life'),
  ('fedora22-ser-2'),
  ('localhost.waffles4.life');

INSERT INTO users (domain, email, password) VALUES
  (1, 'bheesham@waffles4.life', '{SHA512-CRYPT}$6$LBshVwTIbK7cUCL9$EUhZziTcz1p1duvEbNkLGU3vNXHGJ7Qc3kvepXAOWt6qQ9nMl/tsfVQ8bqhoOJK2KLQU3kIB2mB5.W2wJ8XU11');

INSERT INTO aliases (domain, source, dest) VALUES
  (1, 'alias@waffles4.life', 'bhee@waffles4.life');

COMMIT;
