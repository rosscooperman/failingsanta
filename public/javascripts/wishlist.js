$(function() {
  $('.selector select').each(function() {
    $(this).next('input[type=submit]').hide();
    $(this).bind('change', function() {
      window.location = $(this).parents('form').attr('action') + '/' + $(this).val();
    });
  });
});