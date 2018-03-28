set -e
set -u
set -x

ymlfile=cloud-config.yml
ip=192.168.77.208
dir=/tmp/config_boostrap

rm -rf $dir
mkdir -p $dir
wget http://$ip/$ymlfile -O $dir/$ymlfile
coreos-install -d /dev/sda -C stable -c $dir/$ymlfile
