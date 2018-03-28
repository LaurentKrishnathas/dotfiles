ping -c 5 google.com
set -x

echo "$1 `date`">>/tmp/test.bash.log
echo hello
ping -c 5 google.com
exit
