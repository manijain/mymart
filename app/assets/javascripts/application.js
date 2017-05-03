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

$(document).ready(function(){  
  $("#cart-section").click(function() {
   $("div#side").toggle("slow");
  });

  // jQuery.validator.setDefaults({
  // 	debug: true,
  // 	success: 'valid'
  // });

  /* delivery address validation */
  $('#new_customer_address').validate({
	debug: true,
	rules: {
		'customer_address[address1]':{required: true, maxlength: 250 },
		'customer_address[city]':{required: true, maxlength: 250 },
		'customer_address[district]':{required: true, maxlength: 80},
		'customer_address[state]':{required: true, maxlength: 80},
		'customer_address[country]':{required: true, maxlength: 80},
		'customer_address[contact_details]':{required: true, minlength: 10, maxlength: 12, number: true},
		'customer_address[pincode]':{required: true, minlength: 5, maxlength: 7, number: true }
	},

	submitHandler: function(form) {
      form.submit();
    } 
  });

  /* payment validation */
  $('#payment-form').validate({
	debug: true,
	rules: {
		'Card number':{required: true, minlength: 12, maxlength: 19, number: true},
		'Cvv number':{required: true, minlength: 3, maxlength: 3, number: true},
		'Month':{required: true, number: true, minlength: 1, maxlength: 2},
		'Year':{required: true, number: true, minlength: 4, maxlength: 4},
		'Cardholder name':{required: true, maxlength: 80}
	},

	submitHandler: function(form) {
      form.submit();
    } 
  });

  /* customer registration validation */
  $('#new_customer').validate({
	debug: true,
	rules: {
		'customer[first_name]':{required: true, maxlength: 50},
		'customer[last_name]':{required: true, maxlength: 50},
		'customer[email]':{required: true},
		'customer[password]':{required: true, maxlength: 50},
		'customer[password_confirmation]':{required: true, maxlength: 50}
	},

	submitHandler: function(form) {
      form.submit();
    } 
  });


  /* product validation */
  $('#new_product').validate({
  debug: true,
  rules: {
    'product[title]':{required: true, maxlength: 50},
    'product[description]':{required: true, maxlength: 150},
    'product[price]':{required: true, number: true},
    'product[quantity]':{required: true, number: true},
  },

  submitHandler: function(form) {
      form.submit();
    } 
  });

  $('#customer_address_country').change(function(){
    var country = $('#customer_address_country option:selected').val()
    $.ajax({
      url: "/orders/get_shipping",
      type: "GET",
      data: { country_name: country },
      dataType: "script",
        beforeSend : function(){
        },
        success: function(){
          console.log("success");
        },
        complete: function(){
          console.log("success");
        }
    })
});


});

function braintree_setup(token){
  braintree.setup(token, "custom", {id: "payment-form"});
}