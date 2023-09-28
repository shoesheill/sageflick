$(document).ready(function() {
	$.fn.modalica = function(){
		var modalica = $.fn.modalica;
		var body = $('body'); 

		modalica.init = function() {
			body.append('<div class="modalica-modal"><div class="modalica--wrapper"><div class="modalica--wrapper-bg"><div class="modalica--close"><span>×</span></div><div class="modalica--content"></div></div></div></div>');
			// $('.modalica-modal').hide();
		};
		modalica.init();

		var modalica_modal = $('.modalica-modal'),
			modalica_content = modalica_modal.find('.modalica--content');

		this.click(function(event){
			event.preventDefault();
			var content_id = $(this).attr('href');
			modalica.open(content_id);
		});

		$('.modalica--close').click(function(event){
			event.preventDefault();
			modalica.close();
		});

		modalica.open = function( content_id ) {
			body.addClass('modalica-active');
			var html = $(content_id).html();
			if (html === undefined) {
				html = '<p>Erreur</p>';
			}
			modalica_content.empty().append(html);
			modalica_modal.addClass('active');
			
		};

		modalica.close = function() {
			modalica_modal.removeClass('active'); 
			body.removeClass('modalica-active');
		};

	};
});