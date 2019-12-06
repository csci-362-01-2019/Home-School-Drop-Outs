#!/bin/bash

            echo "                                                                                     "

cat << "EOF"
                    _______  _______  _______    _______  _______           _______  _______  _       
            |\     /|(  ___  )(       )(  ____ \  (  ____ \(  ____ \|\     /|(  ___  )(  ___  )( \      
            | )   ( || (   ) || () () || (    \/  | (    \/| (    \/| )   ( || (   ) || (   ) || (      
            | (___) || |   | || || || || (__      | (_____ | |      | (___) || |   | || |   | || |      
            |  ___  || |   | || |(_)| ||  __)     (_____  )| |      |  ___  || |   | || |   | || |      
            | (   ) || |   | || |   | || (              ) || |      | (   ) || |   | || |   | || |      
            | )   ( || (___) || )   ( || (____/\  /\____) || (____/\| )   ( || (___) || (___) || (____/\
            |/     \|(_______)|/     \|(_______/  \_______)(_______/|/     \|(_______)(_______)(_______/
                                                                                                        
                    ______   _______  _______  _______  _______          _________ _______             
                    (  __  \ (  ____ )(  ___  )(  ____ )(  ___  )|\     /|\__   __/(  ____ \            
                    | (  \  )| (    )|| (   ) || (    )|| (   ) || )   ( |   ) (   | (    \/            
                    | |   ) || (____)|| |   | || (____)|| |   | || |   | |   | |   | (_____             
                    | |   | ||     __)| |   | ||  _____)| |   | || |   | |   | |   (_____  )            
                    | |   ) || (\ (   | |   | || (      | |   | || |   | |   | |         ) |            
                    | (__/  )| ) \ \__| (___) || )      | (___) || (___) |   | |   /\____) |            
                    (______/ |/   \__/(_______)|/       (_______)(_______)   )_(   \_______)     

                                     Automated Testing Framework for Moodle
                                  Alex Laughlin, Andrew Nesbett, Chandler Long
                                         CSCI 362 Software Engineering
EOF

            echo "                                                                                     "
            echo "                                                                                     "


# *********************** TABLE OF CONTENTS **************************** #

# Global variables

# Functions

# Menu Selection

# Client server
CLIENT_SERVER=8000

# files.txt locations
TEST_CASES=../testCases/*.txt
METHOD_CASES=../methods/*.txt


# Local directories
TEST_CASE_DIRECTORY=../testCases
METHOD_DIRECTORY=../methods
ORACLE_DIRECTORY=../oracles
PROJECT_DIRECTORY=../project/moodle/
TEST_CASE_EXECUTABLES_DIRECTORY=../testCasesExecutables
DOCS_DIRECTORY=../docs
REPORTS_DIRECTORY=../reports
TEMP_DIRECTORY=../temp

# Client directories
TEST_CASE_EXPORTS=../../TestAutomationClient/storage/app/test_case_exports
JSON_DIRECTORY=../../TestAutomationClient/storage/app/

METHOD_EXPORTS_TEXT=../../TestAutomationClient/storage/app/method_exports/*.txt
METHOD_EXPORTS_DIRECTORY=../../TestAutomationClient/storage/app/method_exports

# Other
EXIT_TESTING_FRAMEWORK= false
COMMAND_LINE_TESTING= false


# Retuns the number of files in a given directory
# Usage: countNumberOfFilesInDirectory /path/sourcefolder
function countNumberOfFilesInDirectory() 
{
    ls -1 $1 | wc -l
}

# Moves all files from one directory to the other
# Usage: moveFilesFromOneDirectoryToAnother /path/sourcefolder/ /path/destinationfolder/
function moveFilesFromOneDirectoryToAnother()
{
    mv $1/* $2
}

# Looks into a directory and returns true if files exist in that directory, false otherwise
# Usage: checkIfNewFilesExist /path/sourcefolder/
function checkIfFilesExist()
{
    fileCount=$(countNumberOfFilesInDirectory $1)
    if [ $fileCount -gt 0 ]; then
        echo "true"
    else
        echo "false"
    fi
}

# Outputs the contents of a file
# Usage: returnContentsOfFile yourFile.txt
function returnContentsOfFile()
{
    cat $1
}

# Takes in a given name and creates a class name for the method php file
# Usage: createClassName YourClassName
function createClassName()
{
    echo "$1"_class
}

# Navigates to a given directory
# Usage: navigateToDirectory /path/sourcefolder/
function navigateToDirectory()
{
    ls
    cd $1
}

# Displays an error message  to the user through the command line
# Usage: showError YOUR ERROR MESSAGE
function showError()
{
    echo "  "
    echo "********************************************************************************"
    echo "ERROR: $1"
    echo "********************************************************************************"
    echo "  "
}

# Displays an alert message  o the user through the command line
# Usage: showAlert YOUR ALERT MESSAGE
function showAlert()
{
    echo " "
    echo    " ========================================================================================= "
    echo    "                                                                                           "
    echo    " $1"
    echo    " "
    echo    " $2"
    echo    "                                                                                           "
    echo    " ========================================================================================= "
    echo " "
}

# Looks into a the official Moodle project and returns 
# Usage: getMethodFromMoodleProject $METHOD_LOCATION $METHOD_LENGTH $METHOD_NAME
function getMethodFromMoodleProject() {
    methodLocation=$PROJECT_DIRECTORY$1
    grep --after-context="$2" --before-context=0 "$3(" $methodLocation
}

# Creates a new method to be tested in the test case executables directory
# Usage: getMethodFromMoodleProject $METHOD_LOCATION $METHOD_LENGTH $METHOD_NAME
function createNewMethod()
{
    cat <<- _FILE_ > $1/$2.php

        <?php
            class $(createClassName $2) {
                $(getMethodFromMoodleProject $METHOD_LOCATION $METHOD_LENGTH $METHOD_NAME)
            }
        ?>

_FILE_
}


PS3='Please enter your choice: '
options=("Enter Testing Framework" "Install Dependencies" "Refresh Client Server" "Manual" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Enter Testing Framework")
            showAlert "ENTERING THE TESTING FRAMEWORK" "Please select an option: "

            options=("Run with Client" "Run with Terminal" "Back")
            select opt in "${options[@]}"
            do
                case $opt in
                    "Run with Client")
                        EXIT_TESTING_FRAMEWORK=false
                        COMMAND_LINE_TESTING=false
                        showAlert "Running Client Automation" "Starting..."

                        # Check if there are any test cases or methods on the client side
                            methodsToAdd=$(checkIfFilesExist $METHOD_EXPORTS_TEXT)
                            testCasesToAdd=$(checkIfFilesExist $TEST_CASES_EXPORTS)

                    if [ "$methodsToAdd" = "true"  ]; then

                        # Move the method cases to the TestAutomation Directory, that way we know 
                        # whether new methods have been added
                        moveFilesFromOneDirectoryToAnother $METHOD_EXPORTS_DIRECTORY $METHOD_DIRECTORY

                        for file in $METHOD_CASES; do
                                echo "========================= NEW METHOD =========================="
                                        # This will loop through each .txt file in the directory
                                METHODS=()

                                while read -r line; do
                                    # Read through text file to get method information
                                    METHODS+=("$line")
                                done < "$file"

                            # Now that we have properly iterrated through a method.txt file, we can now
                            # assign to the values to their appropriate variables 
                            METHOD_NUMBER="${METHODS[0]}"
                            METHOD_DESCRIPTION="${METHODS[1]}"
                            METHOD_NAME="${METHODS[2]}"
                            METHOD_LOCATION="${METHODS[3]}"
                            METHOD_LENGTH="${METHODS[4]}"

                            echo $METHOD_NUMBER
                            echo $METHOD_DESCRIPTION
                            echo $METHOD_NAME
                            echo $METHOD_LOCATION
                            echo $METHOD_LENGTH

                            echo $PROJECT_DIRECTORY$METHOD_LOCATION


                            # Create a new method by grabbing the first line and the resulting lines
                            # specified by METHOD_LENGTH, store this text file in the test case
                            # executables directory
                            createNewMethod $TEST_CASE_EXECUTABLES_DIRECTORY $METHOD_NAME

                            # Once the file has been created we need to update the driver to account for 
                            # the new method...

                            # Insert a require statement below the last require statement in the driver into a new
                            # file in the temp folder
                            sed '/require/ a require("../TestCasesExecutables/$METHOD_NAME");' $TEST_CASE_EXECUTABLES_DIRECTORY/driver.php > $TEMP_DIRECTORY/tempDriver.php

                            # Copy the driver.php file back into the test  case  executables directory
                            # in order to  save properly
                            cp $TEMP_DIRECTORY/tempDriver.php $TEST_CASE_EXECUTABLES_DIRECTORY/driver.php

                            showAlert "METHODS TRANSFERED SUCCESSFULLY" "Executing test cases..."
                        done

                    else
                        showAlert "THERE ARE NO METHODS TO ADD" "Checking test cases..."
                    fi

                    # Check to see if new test cases need to be added
                    if [ "$testToAdd" = "true"  ]; then
                        showAlert "THERE ARE TEST CASES TO ADD" "Transferring test cases..."
                        moveFilesFromOneDirectoryToAnother $TEST_CASES_EXPORTS $TEST_CASE_DIRECTORY

                    else
                        showAlert "THERE ARE NO TEST CASES TO ADD" "Executing test cases..."
                    fi
                        ;;
                    "Run with Terminal")
                        EXIT_TESTING_FRAMEWORK=false
                        COMMAND_LINE_TESTING=true
                        showAlert "Running Terminal Automation" "Starting..."
                        ;;
                    "Back")
                        EXIT_TESTING_FRAMEWORK=true
                        showAlert "EXITING TESTING FRAMEWORK" "Please select an option"
                        echo "1) Enter Testing Framework   2) Install Dependencies"
                        echo "3) Refresh Client Server     4) Manuel"
                        echo "5) Quit"
                        break
                        ;;
                    *) echo "invalid option $REPLY";;
                    
                esac

                # If the user wishe to go back, break out of the second menu loop
                if [ "$EXIT_TESTING_FRAMEWORK" = true  ]; then
                    break
                fi

                for file in $TEST_CASES; do
                    echo "========================= NEW TEST CASE =========================="
                        # This will loop through each .txt file in the directory
                        # setting the full file path to $file
                        TESTCASES=()

                        while read -r line; do
                            # This will loop through each line of the current file
                            # and set the full line to the $line variable
                            first_char="$(printf '%s' "$line" | cut -c1)"
                            if [ "$first_char" = "#" ] || 
                            [ "$first_char" = "=" ] || 
                            [ "$first_char" = "" ]; 
                            then
                                continue
                            else
                                # If the line in the test file is not a comment/empty. We will 
                                # append it to the VALUES array so that we can index it later
                                TESTCASES+=("$line")
                            fi
                        done < "$file"

                        # Now that we have properly iterrated through a testCase.txt file, we can now
                        # assign to the values to their appropriate variables 

                        TEST_CASE_NUMBER="${TESTCASES[0]}"
                        REQUIREMENT="${TESTCASES[1]}"
                        COMPONENT="${TESTCASES[2]}"
                        METHOD="${TESTCASES[3]}"
                        INPUT="${TESTCASES[4]}"
                        EXPECTED="${TESTCASES[5]}"

                        # Display these values in the command line for the user to see
                        echo $TEST_CASE_NUMBER
                        echo $REQUIREMENT
                        echo $COMPONENT
                        echo $METHOD
                        echo $INPUT
                        echo $EXPECTED


                        # Get the oracles directory so we can write out expected output to it
                        filename=$METHOD$TEST_CASE_NUMBER
                        oracleFile="$ORACLE_DIRECTORY/$filename.txt"

                        # Get executables directory to we can check if the method exists
                        methodFile="$TEST_CASE_EXECUTABLES_DIRECTORY/$METHOD.php"

                        # If a valid filename can be constructed
                        if [ "$filename" ]; then 
                            # Write the expected output to the oracle
                            echo $EXPECTED > $oracleFile

                            if [ ! -f "$methodFile" ] ||
                            [ ! -f "$methodFile" ]
                                then
                                    showError "TEST REQUIREMENTS MISSING: ABORTING TEST CASE"
                            else 
                                    # Otherwise, the method exists and we can test it
                                    echo "Starting test..."
                                    # Execute the method, give it the driver, class name, method to text, and its input
                                    methodExecution=$(php ../testCasesExecutables/driver.php $(createClassName $METHOD) "$METHOD" "$INPUT")

                                    # Echo the result of the method so we can compare it to the oracle
                                    echo $methodExecution
                            fi

                            # Lastly we will compare the results we get from our method with the oracle
                            # and write the files to a HTML web browser

                            # Read into oracle file directory
                            result=NULL
                            while IFS= read -r line 
                                do
                                    # Get the result and compare it
                                    myVar=$(echo $methodExecution)
                                    if [ "$myVar" == "$line" ]; then
                                        # Echo pass if the oracle matches the methods output
                                        result=PASS
                                        echo "PASS"
                                    else
                                        # Echo fail it the results do not match
                                        result=FAIL
                                        echo "FAIL"
                                    fi
                            done < "$oracleFile"

                            if [ "$COMMAND_LINE_TESTING" = true  ]; then
                                # Creates the tables in the text file
                                cat <<- _FILE_ >> ../reports/table.html
                                    <tr>
                                        <td>$REQUIREMENT</td>
                                            <td> </td>
                                            <td>$TEST_CASE_NUMBER</td>
                                            <td>$COMPONENT</td>
                                            <td>$METHOD</td>
                                            <td>$INPUT</td>
                                            <td>$EXPECTED</td>
                                            <td>$methodExecution</td>
                                            <td>$result</td>
                                    </tr>
_FILE_
                                    # Import new testcase into HTML template
                                    cat <<- _FILE_ > $REPORTS_DIRECTORY/webpage.html
                                        <html>
                                        <head>
                                            <title>
                                                $title
                                            </title>
                                        </head>
                                        <body>
                                        <table class="table table-striped table-sm">
                                                <thead>
                                                    <tr>
                                                    <th>Requirement<th>
                                                    <th>Id</th>
                                                    <th>Component</th>
                                                    <th>Method</th>
                                                    <th>Input</th>
                                                    <th>Expected</th>
                                                    <th>Result</th>
                                                    <th>Status</th>   
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    $(returnContentsOfFile $REPORTS_DIRECTORY/table.html)
                                                </tbody>
                                                </table>
                                        </body>
                                        </html>
_FILE_
                            fi                      
                            # Export induvidual JSON
                            if [ "$COMMAND_LINE_TESTING" = false  ]; then
                                cat <<- _FILE_ >> $TEMP_DIRECTORY/tempJSON.json
                                    {
                                        "test_case_id": "$TEST_CASE_NUMBER",
                                        "requirement": "$REQUIREMENT",
                                        "component": "$COMPONENT",
                                        "method": "$METHOD",
                                        "input": "$INPUT",
                                        "expected": "$EXPECTED",
                                        "outcome": "$methodExecution",
                                        "result": "$result"

                                    },
_FILE_
                                cat <<- _FILE_ > $TEMP_DIRECTORY/template.json
                                    [
                                        $(returnContentsOfFile $TEMP_DIRECTORY/tempJSON.json)
                                    ]
_FILE_

                            fi

                        else
                            # If the oracle file can be created the test will be aborted
                            showError "ORACLE FILE COULD NOT BE CREATED: ABORTING TEST CASE"
                        fi

                    done

                if [ "$COMMAND_LINE_TESTING" = true  ]; then
                    xdg-open $REPORTS_DIRECTORY/webpage.html 
                fi
            done        
            ;;
        "Install Dependencies")
            showAlert "INSTALLING CLIENT DEPENDENCIES" "Starting..."
            composer global require "laravel/installer=~1.1"
            ;;
        "Refresh Client Server")
            showAlert "REFRESHING CLIENT SERVER" "Starting..."
            alias kill3000="fuser -k -n tcp 8000"
            ;;
        "Manual")
            echo "Opening the manuel"
            cat manual.txt
            ;;
        "Quit")
            showAlert "GOODBYE" "Thank you for using the Moodle Testing Framework!"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done