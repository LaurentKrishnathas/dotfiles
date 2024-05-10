#!/usr/bin/env bash
# every hour 9 to 18 Monday to Friday
#0 9-18 * * mon-fri open -a Terminal "$HOME/Projects/gitlab/dotfiles/crontab/update-scm-projects.bash"
#
0 9 * * * /usr/bin/docker system prune -f
0 * * * * $HOME/code/github/dotfiles/config/crontab/update-scm-projects.bash
