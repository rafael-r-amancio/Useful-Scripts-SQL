-- Linux and Mac
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

-- Windows
mysql --local-infile=1 -u root -p

-- Execute
SET GLOBAL local_infile = true;

-- Load Data
LOAD DATA LOCAL INFILE 'file path'
INTO TABLE `schema`.`table`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;