	// parallax header
	$('#cover-image').css("background-position", "50% 50%");
	$(window).scroll(function() {
		var scroll = $(window).scrollTop(), 
		slowScroll = scroll/4,
		slowBg = 50 - slowScroll;
		if(slowBg < -125){slowBg = -125};
		$('#cover-image').css("background-position", "50% " + slowBg + "%");
	});

$(document).ready(function() {
	
	$('a.gallery-image').colorbox({rel:'gal', maxWidth: '800px'});
	
	if($('.alert')){
		setTimeout(function(){$('.alert').fadeOut("slow"); }, 5000)
	}
	
	/* off canvas menu ======================================= */
	$('.menu-link, .close-menu').on('click', function(){
		$('#wrap').toggleClass('menu-open');
		return false;
	});	
	$('#categoriesMenuLink').click(function(){
		$(this).parent().toggleClass('submenu-open');
		return false;
	});

	/* wow ======================================= */
	new WOW().init({
		offset: 20 
	});

	/* Bootstrap Affix ======================================= */		
	$('#modal-bar').affix({
		offset: {
			top: 10,
		}
	});

	/* Smooth Hash Link Scroll ======================================= */	
	$('.smooth-scroll').click(function() {
		if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
			var target = $(this.hash);
			target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
			if (target.length) {
				$('html,body').animate({
						scrollTop: target.offset().top 
				}, 1000);
				return false;
			}
		}
	});
		
});
