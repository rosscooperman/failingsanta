//= require jquery
//= require jquery_ujs
//= require jquery.ba-bbq.min
//= require jquery.timers-1.2
//= require jquery.colorbox
//= require tinymce/jscripts/tiny_mce/jquery.tinymce
//= require tinymce/jscripts/tiny_mce/tiny_mce
//= require jquery.jselect
//= require message
//= require wishlist
//= require_self

// attach hover functionlity to elements that warrant such treatment
$(function() {
  $("#menu li").hover(
    function() { $(this).addClass('hover'); },
    function() { $(this).removeClass('hover'); }
  );

  $("#feedback a").hover(
    function() {
      var image = $(this).children('img');
      var src   = image.attr('src').replace(/(.*)\.png/, "$1_over.png");
      image.attr('src', src);
    },
    function() {
      var image = $(this).children('img');
      var src   = image.attr('src').replace(/_over/, "");
      image.attr('src', src);
    }
  );
});

function ajaxCancel() {
  $('a.cancel').bind('click', function(e) {
    e.preventDefault();
    $.fn.colorbox.close();
  });
}

// ajaxify forms with the 'ajaxify' class
$(function() {
  $('a.ajaxify').colorbox({ width: '75%', onComplete: ajaxCancel });
});

