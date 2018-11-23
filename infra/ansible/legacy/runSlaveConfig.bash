#! /bin/bash

set -e
set -u
set -x
# ansible-playbook  ci-slave.yml -i inventories/production/hosts --limit ci-slave,svnserve
# ansible-playbook  ci-slave.yml -i inventories/staging/hosts --limit svnserve

ansible-playbook  ci-slave.yml -i inventories/staging/hosts $*


ansible-playbook  ci-slave.yml -i inventories/production/hosts --limit="tst-001" --tags="svnserve"