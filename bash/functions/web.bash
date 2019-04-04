#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

function openUrl {
	echo "/> open $@ ..."
	open "$*"
}

function amazon {
	openUrl "https://www.amazon.co.uk/s/ref=nb_sb_noss?field-keywords=$@"
}

function ebay {
	openUrl "http://www.ebay.co.uk/sch/i.html?&_nkw=$@"
}

function currys {
	openUrl "http://www.currys.co.uk/$@"
}

function dockerhub {
	openUrl "https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=$1&starCount=0"
}


#//TODO currys, argos, ebay, direction, 
 