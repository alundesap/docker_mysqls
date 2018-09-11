#!/bin/bash
#
# run netcat listening on 1234 to simulate a TCP/IP based server
# exec nc -l 1234 &>/dev/null &
#
#
echo "Sleepy..."
sleep 10
# Start the MySQL Server
#
echo "MySQL DB Init."
/usr/lib/mysql/mysql-systemd-helper install
#
echo "MySQL DB Start."
/usr/lib/mysql/mysql-systemd-helper start &>/dev/null &
#
echo "MySQL DB Wait."
/usr/lib/mysql/mysql-systemd-helper wait
#
# Create a test table and populate it a bit
#
echo "MySQL Setup Test2 DB"
/usr/bin/mysql -u root -D test -e "CREATE TABLE test2 (""id"" int(11) NOT NULL AUTO_INCREMENT, ""value"" varchar(45) DEFAULT NULL, PRIMARY KEY (""id"")) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
#
/usr/bin/mysql -u root -D test -e "INSERT INTO test.test2 (value) VALUES('One');"
/usr/bin/mysql -u root -D test -e "INSERT INTO test.test2 (value) VALUES('Two');"
/usr/bin/mysql -u root -D test -e "INSERT INTO test.test2 (value) VALUES('Thareee\!');"
#
/usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -D test -e "SELECT * FROM test.test2;"
#
echo "Settin the MySQL root user password."
echo "/usr/bin/mysqladmin -u root password 'Nirvana8484'"
/usr/bin/mysqladmin -u root password 'Nirvana8484'

