#this script is intended to "list the top-level directory contents of its containing directory in an html file displayed in a browser."-taken from Dr. Bowring's class site
#Homeschool Dropouts
#!/bin/bash

title="My System Directory"
currentTime=$(date +"%x %r %Z")

currentDirectory() 
{
    ls           #list files in directory
}

testAutoDirectory()
{
	cd TestAutomation     #change directory
	ls
}

cat <<- _FILE_ > file.php
<?php

echo "HELLO!!";

?>
_FILE_

xdg-open file.php

