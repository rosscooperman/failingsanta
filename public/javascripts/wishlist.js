// convert 'user select' drop down to js/html/css dropdown that loads the new wishlist using AJAX
$(function() {
  $('.selector select').each(function() {
    $(this).siblings('input[type=submit]').hide();
    $(this).jselect({
      change: function() {
        var url = $(this).parents('form').attr('action') + '/' + $(this).val();
        $('#theirlist').slideUp(125, function() {
          $('#loading').show();
          $.get(url, function(wishlist) {
            $('#loading').hide();
            $('#theirlist').html(wishlist);
            $('#theirlist').slideDown(125);
          });
        });
      }
    });
  });
});
