// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require 'bootstrap-sass'
//= require jquery-ui
//= require jquery.validate
//= require_tree .

$(document).ready(function(){  
  $("#cart-section").click(function() {
   $("div#side").toggle("slow");
  });

  /* delivery address validation */
  $('#new_customer_address').validate({
	debug: true,
	rules: {
		'customer_address[address1]':{required: true},
		'customer_address[city]':{required: true},
		'customer_address[district]':{required: true},
		'customer_address[state]':{required: true},
		'customer_address[country]':{required: true},
		'customer_address[contact_details]':{required: true},
		'customer_address[pincode]':{required: true}
	}
  });

  /* payment validation */
 //  $('#payment-form').validate({
	// debug: true,
	// rules: {
	// 	'customer_address[pincode]':{required: true},
	// 	'customer_address[address1]':{required: true},
	// 	'customer_address[city]':{required: true},
	// 	'customer_address[district]':{required: true},
	// 	'customer_address[state]':{required: true},
	// 	'customer_address[country]':{required: true},
	// 	'customer_address[contact_details]':{required: true},
	// }
 //  });

});

function braintree_setup(token){
  braintree.setup(token, "custom", {id: "payment-form"});
}

$(document).ready(function(){
	
});