#!/usr/bin/env sh
# @author Laurent Krishnathas

set -e
set -u
set -x

echo "$CROND_REGEX su -c \"$HOME/current_script.sh\" -s /bin/sh $SERVER_USER">$HOME/crontab.txt
echo "">>$HOME/crontab.txt

cp $CRON_SCRIPT $HOME/current_script.sh
chmod 755 $HOME/current_script.sh
cat $HOME/current_script.sh
cat $HOME/crontab.txt
/usr/bin/crontab  $HOME/crontab.txt
/usr/bin/crontab  -l
date
/usr/sbin/crond -f $CROND_ARGS
