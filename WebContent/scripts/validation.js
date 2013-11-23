// A regular expression to match an email address
var emailRegex = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'; 

// Make sure this string is valid
function validateString(input) {
    for (var x = 0; x < input.length; x++) {
        if (!validChar(input.charAt(x).charCodeAt(0)))
            return false;
    }
    return true;
}

// Validate password (must be at least 6 chars long and contain no spaces)
function validatePassword(input) { 
    return input.length > 5 && (input.indexOf(" ") == -1) && validateString(input);
}

// Validate email
function validateEmail(input) {
    return input.match(emailRegex);
}

//Make sure this char is valid (space,0-9,a-z,A-Z)
function validChar(ch) {
    return (ch == 32) || (ch > 47 && ch < 58) || (ch > 64 && ch < 91) || (ch > 96 && ch < 123);
}