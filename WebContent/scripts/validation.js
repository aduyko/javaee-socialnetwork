// A regular expression to match an email address
var emailRegex = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
var simpleDateRegex = '[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}';

// Make sure this string is valid
function validateString(input) {
    for (var x = 0; x < input.length; x++) {
        if (!validChar(input.charAt(x).charCodeAt(0)))
            return false;
    }
    return true;
}

// Make sure this string is valid for messages
function validateMessageString(input) {
	for(var x = 0; x < input.length; x++) {
		if(!validCharMessage(input.charAt(x).charCodeAt(0)))
			return false;
	}
	return true;
}

// Make sure this string is made up of only numbers
function validateNumberString(input) {
	for(var x = 0; x < input.length; x++) {
		if(!isNumber(input.charAt(x).charCodeAt(0)))
			return false;
	}
	return true;
}

// Validate password (must be at least 6 chars long and contain no spaces)
function validatePassword(input) { 
    return input.length > 5 && input.length <=50 && (input.indexOf(" ") == -1) && validateMessageString(input);
}

// Validate a first or last name
function validateName(input) {
	return input.length > 2 && input.length <= 50 && validateString(input);
}

// Validate email
function validateEmail(input) {
    return input.match(emailRegex) && input.length <= 50;
}

// Validate address
function validateAddress(input) {
	return input.length > 0 && input.length < 100 && validateMessageString(input);
}

// Function validate date
function validateDate(input) {
	return input.match(simpleDateRegex);
}

// Validate city
function validateCity(input) {
	return input.length > 0 && input.length < 50 && validateMessageString(input);
}

// Validate message body
function validateMessageBody(input) {
	return input.length > 0 && input.length < 1000 && validateMessageString(input);
}

// Validate message subject
function validateMessageSubject(input) {
	return input.length > 0 && input.length < 50 && validateMessageString(input);
}

// Validate zipcode
function validateZipCode(input) {
	return input.length == 5 && validateNumberString(input);
}

// Validate phone number
function validatePhone(input) {
	return input.length == 10 && validateNumberString(input);
}

// Validate credit card number
function validateCreditCard(input) {
	return input.length == 16 && validateNumberString(input);
}

// Validate social security number
function validateSSN(input) {
	return input.length == 9 && validateNumberString(input);
}

function isNumber(ch) {
	return (ch > 47 && ch < 58);
}

//Make sure this char is valid for names (space,0-9,a-z,A-Z)
function validChar(ch) {
    return (ch == 32) || (ch > 47 && ch < 58) || (ch > 64 && ch < 91) || (ch > 96 && ch < 123);
}

// Make sure this char is valid for messages
function validCharMessage(ch) {
	return (ch > 31) && (ch != 34) && (ch != 39) && (ch != 47) && (ch != 92) && (ch != 96) && (ch < 127);
}