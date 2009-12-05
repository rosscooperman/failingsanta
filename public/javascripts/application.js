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