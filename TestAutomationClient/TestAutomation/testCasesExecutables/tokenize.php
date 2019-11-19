
<?php

    class tokenize_class {

            public static function tokenize($needle) {

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

        return array_values($tokens);
    }

    }

?>

