$(function() {
  $("#menu li").hover(
    function() { $(this).addClass('hover'); },
    function() { $(this).removeClass('hover'); }
  )
});