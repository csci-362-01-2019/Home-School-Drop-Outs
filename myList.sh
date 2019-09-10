#!/bin/bash

title="My System Directory"
currentTime=$(date +"%x %r %Z")

currentDirectory() 
{
    ls
}

testAutoDirectory()
{
	cd TestAutomation
	ls
}

cat <<- _FILE_ > file.html
    <html>
    <head>
        <title>
			$title
        </title>
    </head>
    <body>
    <h1>My System Directory!</h1>
    <h3>Current Session: $currentTime</h3>
    <h4>Top Directory</h4>
		$(currentDirectory)
    <h4>TestAutomation Directory</h4>\
		$(testAutoDirectory)
		</br>
		</br>
	<h2>Thank you for executing my script!</h2>
	<img src="./TestAutomation/img/pair-programming.gif">
    </body>
    </html>
_FILE_

xdg-open file.html

