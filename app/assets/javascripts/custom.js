$(document).ready(function() { 	
  $(window).scroll(function() {
  	if ($(this).scrollTop() > 100) {
  		$('.scroll-up').fadeIn();
  	} else {
  		$('.scroll-up').fadeOut();
  	}
  });

  $('.scroll-up').click(function() {
  	$("html, body").animate({
  		scrollTop: 0
  	}, 600);
  	return false;
  });

  $(window).scroll(function(){	
  	"use strict";	
  	var scroll = $(window).scrollTop();
  	if( scroll > 60 ){		
  		$(".navbar").addClass("navbar-scroll");				
  	} else {
  		$(".navbar").removeClass("navbar-scroll");
  	}
  });

  $(".quick-links li a[href^='#']").on('click', function(e) {
      e.preventDefault();
      $('html, body').animate({
          scrollTop: $(this.hash).offset().top
      }, 1000);
  });

  $(".navbar-nav li a[href^='#']").on('click', function(e) {
      e.preventDefault();
      $('html, body').animate({
          scrollTop: $(this.hash).offset().top
      }, 1000);
  });

  function toggleIcon(e) {
  	$(e.target)
  		.prev('.panel-heading')
  		.find('.panel-title a')
  		.toggleClass('active')
  		.find("i.fa")
  		.toggleClass('fa-plus-square fa-minus-square');
  }
  $('.panel').on('hidden.bs.collapse', toggleIcon);
  $('.panel').on('shown.bs.collapse', toggleIcon);

});