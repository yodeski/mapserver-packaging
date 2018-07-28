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
 
 
