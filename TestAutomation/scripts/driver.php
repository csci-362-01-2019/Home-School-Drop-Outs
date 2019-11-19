<?php

// Inset new methods to test here
require("../testCasesExecutables/tokenize.php");


// Position [0] is the script's file name
array_shift($argv);
$className = array_shift($argv);
$funcName = array_shift($argv);
$result = call_user_func_array(array($className, $funcName), $argv);
print_r($result)
?>