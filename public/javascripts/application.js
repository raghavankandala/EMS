// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var an_page = 2;
var new_quote = null;
var rotate_quote = true;

function hideFlashMessage() {
   if($("flash_notice")) {
      $("flash_notice").hide();
   }
   else if($("flash_error")) {
      $("flash_error").hide();
   }
}

function IamAStudent(checkbox_obj) {
	if(checkbox_obj.checked) {
		$("college_select").show();
		$("custom_college_name").hide();
	}
	else {
		$("college_select").hide();
		$("custom_college_name").hide();
		$("registration_college_name").value = "";
		$("custom_college_text_box").value = "";
		$("college_select_box").selectedIndex = 0;
	}
}

function myCollegeIsNotListed() {
	$("custom_college_name").show();
	$("college_select").hide();
}

function selectFromTheList() {
	$("custom_college_name").hide();
	$("college_select").show();
}

function updateCollegeValue(value) {
	$("registration_college_name").value = value;
}

// opens a new browser window and loads it with the given url
function myPopup(mylink, windowname){
    if (! window.focus)return true;
    var href;
    if (typeof(mylink) == 'string')
        href=mylink;
    else
        href=mylink.href;
    window.open(href, windowname, 'width=645,height=510,scrollbars=yes');
    return false;
}

function flash_text() {
	if($("flash_text")) {
		new Effect.Pulsate("flash_text", {pulses:3, duration: 2});
	}
}

function externalPr(checkbox_obj) {
	if(checkbox_obj.checked) {
		$("external_pr_container").show();
		$("internal_pr_container").hide();
	}
	else {
		$("external_pr_container").hide();
		$("internal_pr_container").show();
	}
}

function fetch_attendees(event_id) {
   new Ajax.Request('/registrants/'+event_id, {method: 'get', asynchronous:true, evalScripts:true});
}

function announcement() {
	if($('quotes') && rotate_quote) {
   	new Ajax.Request('/announcement?page='+an_page, {method: 'get', asynchronous:true, evalScripts:true});
	}
}

function show_quote(nq) {
	$('quotes').innerHTML = new_quote;
	new Effect.BlindDown('quotes');
}

function change_quote(quote) {
	new_quote = quote;
	new Effect.BlindUp('quotes');
	setTimeout("show_quote()", 2000);
}


function showIntro() {
	$("intro").show();
	$("quotes").hide();
	$("quote_hr").hide();
}

function showQuotes() {
	$("intro").hide();
	$("quotes").show();
	$("quote_hr").show();
}

function stop_quote_rotation() {
	rotate_quote = false;
}

function run_quote_rotation() {
	rotate_quote = true;
}
