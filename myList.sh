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
	<h2>Thank you for executing my script!</h2>      #header
	<img src="./TestAutomation/img/pair-programming.gif">    #paired programming gif
    </body>
    </html>
_FILE_

xdg-open file.html

