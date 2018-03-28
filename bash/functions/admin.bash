
function restartWifi {		#... .restartWifi
	echo "enter admin password"
	su admin -c "echo 'stopping wifi ...';sudo ifconfig en0 down;echo 'starting wifi ...'; sudo ifconfig en0 up; echo Done"
}

function test_function {
    echo "test_function OK"
}