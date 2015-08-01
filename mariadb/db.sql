BEGIN;

CREATE DATABASE IF NOT EXISTS mail
  DEFAULT CHARACTER SET 'utf8';

USE mail;

CREATE TABLE IF NOT EXISTS domains (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  domain VARCHAR(50) NOT NULL,
  relay TINYINT(1) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE(domain)
);

-- We don't want to set uid, gid, home, or mail
-- settings from the database. Let's just keep
-- that stuff in Dovecot's configuration.
CREATE TABLE IF NOT EXISTS users (
  id BIGINT NOT NULL AUTO_INCREMENT,
  email VARCHAR(128) NOT NULL,
  domain BIGINT REFERENCES domains(id),
  password VARCHAR(128) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS aliases (
  id BIGINT NOT NULL AUTO_INCREMENT,
  alias VARCHAR(128) NOT NULL,
  email VARCHAR(128) REFERENCES users(email),
  PRIMARY KEY (id),
  UNIQUE (alias)
);

TRUNCATE domains;
TRUNCATE users;
TRUNCATE aliases;

INSERT INTO domains (domain, relay) VALUES ('192.168.122.86', 0);
INSERT INTO domains (domain, relay) VALUES ('localhost', 0);
INSERT INTO users (email, domain, password) VALUES
  ('bhee@192.168.122.86', 1, '{SHA512-CRYPT}$6$LBshVwTIbK7cUCL9$EUhZziTcz1p1duvEbNkLGU3vNXHGJ7Qc3kvepXAOWt6qQ9nMl/tsfVQ8bqhoOJK2KLQU3kIB2mB5.W2wJ8XU11');
INSERT INTO aliases (alias, email) VALUES ('test@localhost', 'bhee@192.168.122.86');

COMMIT;
