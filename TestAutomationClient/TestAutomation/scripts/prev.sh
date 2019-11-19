  
#!/bin/bash
TEST_CASE_DIRECTORY=../testCases/*.txt
ORACLE_DIRECTORY=../oracles
PROJECT_DIRECTORY=../project/moodle

for file in $TEST_CASE_DIRECTORY; do
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
    OUTPUT="${VALUES[5]}"

    echo $TEST_CASE_NUMBER
    echo $REQUIREMENT
    echo $COMPONENT
    echo $METHOD
    echo $INPUT
    echo $OUTPUT

    # Using the TEST_CASE_NUMBER variable we can determine the component path 
    # as well as any specific drivers we need to access. But first it would
    # be wise to go ahead and write to the oracle so we can compare our expected
    # output later

    # Future implementations could include dates, times, etc in order to give
    # more insight into when these tests were ran

    FILENAME=$METHOD$TEST_CASE_NUMBER

    if [ "$FILENAME" ]; then 
        echo $OUTPUT > "$ORACLE_DIRECTORY/$FILENAME.txt"
    else
        echo "The file was not created successfully!"
    fi

    # Now that we have written to the oracle, we can call upon our methods so that
    # we can get the offical tests results back from the method

    # First lets decide which driver or component path we need to call upon
    # in order to test our methods

    # Condiiton for test case number 001
    if [ $TEST_CASE_NUMBER -ge 001 ]; then 
        
        # Call upon the tokenize method
        #METHOD_DIRECTORY=$PROJECT_DIRECTORY/lib/grade/
        echo "Starting test..."
        TOKENIZE=$(php driver.php grading_manager tokenize "$INPUT")
        echo $TOKENIZE
    fi


    oracleFile="$ORACLE_DIRECTORY/$FILENAME.txt"
    while IFS= read -r line 
    do
    myVar=$(echo ${TOKENIZE:53})
    if [ "$myVar" == "$line" ]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
    done < "$oracleFile"


    # For now we have found an option that allows us to execute moodle methods
    # without the need for a driver. However, we may need to use a driver in the
    # future to instantiate objects in order to do further testing


    # Lastly we will compare the results we get from our method with the oracle
    # and write the files to a HTML web browser


done

function parseTestCasesIntoArray()
{
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
                echo "$line"
            fi
        done < "$1"
}

function testFiles() 
{
    for file in $1; do
    #echo "========================= NEW TEST CASE =========================="
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
    done
    echo ${VALUES[*]}

}