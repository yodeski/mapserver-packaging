# activate ol7_optional_latest and EPEL
sudo yum-config-manager --enable ol7_optional_latest
sudo yum update -y
sudo yum install -y tar wget
sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh epel-release-7-10.noarch.rpm

# do the RPM build
sudo yum -y install rpm-build rpmdevtools yum-utils
sudo rpmdev-setuptree
sudo spectool -g -C ~/rpmbuild/SOURCES mapserver-7.0.spec
sudo yum-builddep -y mapserver-7.0.spec
sudo QA_RPATHS=$[ 0x0001|0x0002 ] rpmbuild -ba --target x86_64 mapserver-7.0.spec

#post instalation
 cd /root/rpmbuild/BUILD/mapserver-7.0.0/build
 sudo cp libmapserver.so.2 /usr/lib64/
 sudo cp libmapserver.so /usr/lib/
 sudo cp libmapserver.so.7.0.0 /usr/lib64/
 
 
#after create appgiswms directory
sudo chown apache:apache -R /var/www/appgiswms
cd /var/www/appgiswms
 
# File permissions, recursive
find . -type f -exec chmod 0644 {} \;
 
# Dir permissions, recursive
find . -type d -exec chmod 0755 {} \;
 
# SELinux serve files off Apache, resursive
sudo chcon -t httpd_sys_content_t /var/www/appgiswms -R
 
# Allow write only to specific dirs
sudo chcon -t httpd_sys_rw_content_t /var/www/appgiswms -R
sudo chcon -t httpd_sys_rw_content_t /var/www/appgiswms -R


#postgresql
#config files:
#/var/lib/pgsql/data/pg_hba.conf
sudo postgresql-setup initdb
sudo systemctl enable postgresql

#interactive psql with postgres user
#sudo -i -u postgres
#dir osm2pgsql style: /usr/share/osm2pgsql/

#where are mapserver libs inatalled:
#/root/rpmbuild/BUILD/mapserver-7.0.0/

