//Password confirm doesn't update if password is changed unless field is clicked or typed in

var typingTimer;            
var typingInterval = 1000;

function checkEmail() {
	var text = this.value;
	var parent = this.parentNode;

	clearTimeout(typingTimer);
	
	if (isValidEmail(text))
		parent.className = "has-success";
		
	else if (text != '') {
		this.parentNode.className = "has-warning";
	    typingTimer = setTimeout(function() {
	    										if (!isValidEmail(text))
	    											parent.className = "has-error";
	    									}, typingInterval);
	}
	
	else
		parent.className = "";
}

function checkPassword() {
	var text = this.value;
	var parent = this.parentNode;

	clearTimeout(typingTimer);
	
	if (isValidPassword(text))
		parent.className = "has-success";
		
	else if (text != '') {
		this.parentNode.className = "has-warning";
	    typingTimer = setTimeout(function() {
	    										if (!isValidPassword(text))
	    											parent.className = "has-error";
	    									}, typingInterval);
	}
	
	else
		parent.className = "";
}

function confirmPassword() {
	var text = this.value;
	var original = document.getElementById('password-input').value;
	var parent = this.parentNode;

	clearTimeout(typingTimer);
	
	if (isValidConfirmPassword(original, text))
		parent.className = "has-success";
		
	else if (text != '') {
		this.parentNode.className = "has-warning";
	    typingTimer = setTimeout(function() {
	    										if (!isValidConfirmPassword(original, text))
	    											parent.className = "has-error";
	    									}, typingInterval);
	}
	
	else
		parent.className = "";
}

function isValidEmail(email) {
	var email_regex = /^[^0-9][A-z0-9_]+([.][A-z0-9_]+)*[@][A-z0-9_]+([.][A-z0-9_]+)*[.][A-z]{2,4}$/i;
	return email_regex.test(email);
}

function isValidPassword(password) {
	return password.length >= 8;
}

function isValidConfirmPassword(password, password_confirm) {
	return (password == password_confirm && isValidPassword(password));
}