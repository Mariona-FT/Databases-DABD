CREATE TABLE tec (dni int NOT NULL, dp text, PRIMARY KEY(dni));
CREATE TABLE maq (ninv int NOT NULL, fab text, PRIMARY KEY(ninv));
CREATE TABLE evsup (fh text NOT NULL, PRIMARY KEY(fh));
CREATE TABLE supervisio (
  dni int NOT NULL,
  ninv int NOT NULL,
  fh text NOT NULL,
  FOREIGN KEY (dni) REFERENCES tec ON UPDATE CASCADE, 
  FOREIGN KEY (ninv) REFERENCES maq ON UPDATE CASCADE,
  FOREIGN KEY (fh) REFERENCES evsup ON UPDATE CASCADE,
  PRIMARY KEY(fh,dni), UNIQUE(fh,ninv));

CREATE TABLE tec (dni int NOT NULL PRIMARY KEY, dp text);
CREATE TABLE maq (ninv int NOT NULL PRIMARY KEY, fab text);
CREATE TABLE evsup (fh text NOT NULL PRIMARY KEY);
CREATE TABLE supervisio (
  dni int NOT NULL REFERENCES tec ON UPDATE CASCADE,
  ninv int NOT NULL REFERENCES maq ON UPDATE CASCADE,
  fh text NOT NULL REFERENCES evsup ON UPDATE CASCADE, 
  PRIMARY KEY(fh,dni), UNIQUE(fh,ninv));

.schema
.schema supervisio

INSERT INTO supervisio VALUES (1, 100, "2020-03-02 08:30-10:30");

PRAGMA foreign_keys = ON;
INSERT INTO supervisio VALUES (2, 200, "2020-03-02 08:30-10:30");
INSERT INTO tec VALUES(2, "dp2");
INSERT INTO maq VALUES(200, "SEAT");
INSERT INTO evsup VALUES("2020-03-02 08:30-10:30");
INSERT INTO supervisio VALUES (2, 200, "2020-03-02 08:30-10:30");
SELECT * FROM supervisio;
INSERT INTO supervisio VALUES (1, 100, "2020-03-03 15:30-17:30");

SELECT * FROM tec;
UPDATE tec SET dni=5 WHERE dni=2;
SELECT * FROM tec;
SELECT * FROM supervisio;
DELETE FROM tec WHERE dni=5;

PRAGMA foreign_keys = OFF;
DELETE FROM tec WHERE dni=5;
