$(function() {
  $('.selector select').each(function() {
    $(this).siblings('input[type=submit]').hide();
    $(this).jselect({
      change: function() {
        window.location = $(this).parents('form').attr('action') + '/' + $(this).val();
      }
    });
  });
});