<?php

$inFile = "test.txt";


function getFile($inFile)
{
    $arrayInputs = array();
    $fileLine;
    $myfile = fopen($inFile, "r") or die("Unable to open file!");
    // Output one line until end-of-file
    while(!feof($myfile)) {
      $fileLine = fgets($myfile);
      array_push($arrayInputs, $fileLine);
    }
    fclose($myfile);
    return $arrayInputs[4];
}

function tokenize($needle)
{

    // check if we are searching for the exact phrase
    if (preg_match('/^[\s]*"[\s]*(.*?)[\s]*"[\s]*$/', $needle, $matches)) {
        $token = $matches[1];
        if ($token === '') {
            return array();
        } else {
            return array($token);
        }
    }

    // split the needle into smaller parts separated by non-word characters
    $tokens = preg_split("/\W/u", $needle);
    // keep just non-empty parts
    $tokens = array_filter($tokens);
    // distinct
    $tokens = array_unique($tokens);
    // drop one-letter tokens
    foreach ($tokens as $ix => $token) {
        if (strlen($token) == 1) {
            unset($tokens[$ix]);
        }
    }
    return $tokens;
}

print(tokenize(getFile($inFile))[0]);
?>