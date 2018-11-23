echo hello
ls -la bbb
goss validate --format junit || exit  1
echo $?
echo after bla
