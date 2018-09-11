FROM alunde/opensuse:42.3
MAINTAINER andrew.lunde@sap.com

ENV GOPATH /go
ENV NAME chisel
ENV PACKAGE github.com/jpillora/$NAME
ENV PACKAGE_DIR $GOPATH/src/$PACKAGE

#Install more stuff if needed
RUN zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution go git-core lsof netcat hostname mariadb mariadb-client mariadb-tools \
	&& mkdir -p $PACKAGE_DIR \
	&& git clone https://$PACKAGE.git $PACKAGE_DIR \
	&& cd $PACKAGE_DIR \
	&& go build -ldflags "-X github.com/jpillora/chisel/share.BuildVersion=$(git describe --abbrev=0 --tags)" -o /usr/bin/$NAME 
#
# zypper in mariadb mariadb-client mariadb-tools // MySQL
# /usr/lib/mysql/mysql-systemd-helper install
# /usr/lib/mysql/mysql-systemd-helper start
# /usr/bin/mysqladmin -u root password 'Nirvana8484'
#
COPY entrypoint.sh /usr/local/bin/
COPY start_mysql.sh /usr/local/bin/
COPY auth.json /usr/bin/
EXPOSE 8080
#
#run!
#Moved to entrypoint.sh
#ENTRYPOINT chisel server -v --port 8080 --authfile /usr/bin/auth.json
ENTRYPOINT ["entrypoint.sh"]
