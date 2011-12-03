// convert 'user select' drop down to js/html/css dropdown that loads the new wishlist using AJAX
$(function() {
  $('.selector select').each(function() {
    $(this).siblings('input[type=submit]').hide();
    $(this).jselect({
      change: function() {
        $.bbq.pushState({ list: $(this).val() });
      }
    });
  });

  $(window).bind('hashchange', function(e, load) {
    var list = $.bbq.getState('list');
    if (list != undefined) {
      //TODO fix the fact that the path here is hard-coded
      var url = '/wishlists/' + list;

      if (load) {
        $('#theirlist').html('');
        $('#loading').show();
        $('#theirlist').load(url, function() { $('#loading').hide(); });
      }
      else {
        $('#theirlist').slideUp(125, function() {
          $('#loading').show();
          $.get(url, function(wishlist) {
            $('#loading').hide();
            $('#theirlist').html(wishlist);
            $('#theirlist').slideDown(125);
          });
        });
      }
    }
  });

  $(window).trigger('hashchange', true);
});
