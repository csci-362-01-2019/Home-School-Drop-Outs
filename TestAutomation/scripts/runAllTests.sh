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
TEST_CASE_EXPORTS=../../TestAutomationClient/app/executables/test_case_exports
JSON_DIRECTORY=../../TestAutomationClient/app/executables

METHOD_EXPORTS_TEXT=../../TestAutomationClient/app/executables/method_exports/*.txt
METHOD_EXPORTS_DIRECTORY=../../TestAutomationClient/app/executables/method_exports


# Retuns the number of files in a given directory
# Usage: countNumberOfFilesInDirectory /path/sourcefolder
function countNumberOfFilesInDirectory() 
{
    ls -1 $1 | wc -l
}

# Moves files from one directory to the other
# Usage: moveFilesFromOneDirectoryToAnother /path/sourcefolder/ /path/destinationfolder/
function moveFilesFromOneDirectoryToAnother()
{
    mv $1/* $2
}

# Looks into a directory and returns true if files exist, false otherwise
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
function returnContentsOfFile()
{
    cat $1
}

function createClassName()
{
    echo "$1"_class
}

function navigateToDirectory()
{
    ls
    cd $1
}

function showError()
{
    echo "  "
    echo "********************************************************************************"
    echo "ERROR: $1"
    echo "********************************************************************************"
    echo "  "
}



PS3='Please enter your choice: '
options=("Run tests with client" "Run tests with command line" "Manuel" "Quit")
select opt in "${options[@]}"
do
    case $opt in



            # ========================================================================================= #
            #                                                                                           #
            #                            RUN TEST CASES WITH THE CLIENT                                 #
            #                                                                                           #
            # ========================================================================================= #



        "Run tests with client")
            echo "Running tests with client"

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
                                METHODS+=("$line")
                            fi
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



# Looks into a the official Moodle project and returns 
# Usage: 
function getMethodFromMoodleProject() {
    methodLocation=$PROJECT_DIRECTORY$METHOD_LOCATION
    grep --after-context=26 --before-context=0 "$METHOD_NAME(" $methodLocation
}

# Take the grerpped file and put it into a valid php class file, store in test case executables
cat <<- _FILE_ > $TEST_CASE_EXECUTABLES_DIRECTORY/$METHOD_NAME.php

<?php
    class $(createClassName $METHOD_NAME) {
        $(getMethodFromMoodleProject)
    }
?>

_FILE_

                # Once the file has been created we need to update the driver to account for 
                # the new method

                # 



# By this point we have grabbed any new methods, read through them and saved the method to 
# testCasesExecutables, and lastly updated the driver we can now check for new test cases

        done

            else
                echo "There are no methods to add"
            fi

            # Check to see if new test cases need to be added
            if [ "$testToAdd" = "true"  ]; then
                echo "There are new test cases to add"
                moveFilesFromOneDirectoryToAnother $TEST_CASES_EXPORTS $TEST_CASE_DIRECTORY

            else
                echo "There are no tests to add"
            fi

            # All of our methods and test cases have been accounted for, time to run all
            # of our test cases

            for file in $TEST_CASES; do
                echo "========================= NEW TEST CASE =========================="
                    # This will loop through each .txt file in the directory
                    # setting the full file path to $file
                    # I recommend adding the .txt if you know all your files
                    # will have that extension otherwise the following is fine:
                    # for file in /path/to/files/*; do

                    VALUES=()

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
                            VALUES+=("$line")
                        fi
                    done < "$file"

                    # Now that we have properly iterrated through a testCase.txt file, we can now
                    # assign to the values to their appropriate variables 

                    TEST_CASE_NUMBER="${VALUES[0]}"
                    REQUIREMENT="${VALUES[1]}"
                    COMPONENT="${VALUES[2]}"
                    METHOD="${VALUES[3]}"
                    INPUT="${VALUES[4]}"
                    EXPECTED="${VALUES[5]}"

                    echo $TEST_CASE_NUMBER
                    echo $REQUIREMENT
                    echo $COMPONENT
                    echo $METHOD
                    echo $INPUT
                    echo $EXPECTED


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

                        # Read into oracle file directory
                        while IFS= read -r line 
                            do
                                # Get the result and compare it
                                myVar=$(echo $methodExecution)
                                if [ "$myVar" == "$line" ]; then
                                    # Echo pass if the oracle matches the methods output
                                    echo "PASS"
                                else
                                    # Echo fail it the results do not match
                                    echo "FAIL"
                                fi
                        done < "$oracleFile"

                    else
                        showError "ORACLE FILE COULD NOT BE CREATED: ABORTING TEST CASE"
                    fi
            
done


            ;;




            # ========================================================================================= #
            #                                                                                           #
            #                            RUN TEST CASES WITH COMMAND LINE                               #
            #                                                                                           #
            # ========================================================================================= #




        "Run tests with command line")
            echo "Running test cases with command line: "
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
                        while IFS= read -r line 
                            do
                                # Get the result and compare it
                                myVar=$(echo $methodExecution)
                                if [ "$myVar" == "$line" ]; then
                                    # Echo pass if the oracle matches the methods output
                                    echo "PASS"
                                else
                                    # Echo fail it the results do not match
                                    echo "FAIL"
                                fi
                        done < "$oracleFile"

                    else
                        # If the oracle file can be created the test will be aborted
                        showError "ORACLE FILE COULD NOT BE CREATED: ABORTING TEST CASE"
                    fi
done
            ;;


            # ========================================================================================= #
            #                                                                                           #
            #                            VIEW THE TEST AUTOMATION MANUEL                                #
            #                                                                                           #
            # ========================================================================================= #


        "Manuel")
            echo "you chose choice $REPLY which is $opt"

            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done