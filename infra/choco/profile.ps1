
echo "loading $profile ..."
function get-gitstatus { git status }

Set-Alias -Name gst -Value get-gitstatus

