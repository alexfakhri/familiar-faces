// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require masonry/jquery.masonry
//= require jquery.purr
//= require best_in_place
//= require disqus_rails
// = require turbolinks
//= require gmaps
//= require_tree .



$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});

var ready;
var ready = function() {
$(function() {
  return $('#articles-grid').imagesLoaded(function() {
    return $('#articles-grid').masonry({
      itemSelector: '.box',
      isFitWidth: true
    });
  });
});
};

$(document).ready(ready);
$(document).on('page:load', ready);

// MENU BAR JAVASCRIPT
var ready;
var ready = function() {
  (function($) {
      "use strict"; // Start of use strict

      // Closes the Responsive Menu on Menu Item Click
      $('.navbar-collapse ul li a').click(function() {
          $('.navbar-toggle:visible').click();
      });

      // Offset for Main Navigation
      $('#mainNav').affix({
          offset: {
              top: 50
          }
      })

  })(jQuery); // End of use strict
};

$(document).ready(ready);
$(document).on('page:load', ready);

// $('a.page-scroll').bind('click', function(event) {
//         var $anchor = $(this);
//         $('html, body').stop().animate({
//             scrollTop: ($($anchor.attr('href')).offset().top - 50)
//         }, 1250, 'easeInOutExpo');
//         event.preventDefault();
//     });
