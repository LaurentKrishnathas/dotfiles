#
# @author Laurent Krishnathas
# @year 2019

function restartWifi {		#... .restartWifi
	echo "enter admin password"
	su admin -c "echo 'stopping wifi ...';sudo ifconfig en0 down;echo 'starting wifi ...'; sudo ifconfig en0 up; echo Done"
}

function test_function {
    echo "test_function OK"
}

function volume {		#... .restartWifi
  osascript -e "set volume output volume $1"	
}


