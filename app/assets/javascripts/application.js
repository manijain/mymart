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
//= require jquery.validate
//= require jquery_ujs
//= require 'bootstrap-sass'
//= require jquery-ui
//= require_tree .

$(document).ready(function(){  
  $("#cart-section").click(function() {
   $("div#side").toggle("slow");
  });
});

function braintree_setup(token){
  braintree.setup(token, "custom", {id: "payment-form"});
}

// $(document).ready(function(){
// 	$(“#new_order").validate({
// 	debug: true,
// 	rules: {
// 		“order[name]“:{required: true},
// 		“order[address]“:{required: true}
// 	}
//   });
// });