// function fixMessageLinks() {
//   $('#messages li a').each(function() {
//     var link = $(this).attr('href');
//     var li = $(this).parents('li');
//     var content = $(this).html();
//     $(this).replaceWith(content);
//     li.css('cursor', 'pointer');
//     li.click(function(e) { document.location = link });
//   });
//
//   $('#messages li:not([class~=nomessage])').hover(
//     function() { $(this).addClass('hover'); },
//     function() { $(this).removeClass('hover'); }
//   );
// }
//
// $(function() {
//   var baseUrl = $("script[src*='application.js']").attr('src');
//   baseUrl = baseUrl.replace(/javascripts\/application\.js(\?\d+)?$/, '');
//   $('#message_body').tinymce({
//     extended_valid_elements: "img[src|alt|mce_src|title|border]",
//     document_base_url: baseUrl,
//     relative_urls: false,
//     theme: "advanced",
//     plugins: "safari,emotions",
//     content_css: $("link[href*='tinymce.css']").attr('href'),
//
//     theme_advanced_toolbar_location: "top",
//     theme_advanced_toolbar_align:    "left",
//     theme_advanced_layout_manager:   "RowLayout",
//
//     theme_advanced_containers: "controls,editor",
//     theme_advanced_container_controls: "bold,italic,underline,strikethrough,|," +
//                                        "forecolor,backcolor,|," +
//                                        "numlist,bullist,|," +
//                                        "emotions",
//     theme_advanced_container_controls_align: "left",
//     theme_advanced_container_editor: "mceEditor"
//   });
//
//   fixMessageLinks();
//
//   $('#mailboxes li a').click(function(e) {
//     $('#mailboxes li').removeClass('current');
//     var url = $(this).attr('href');
//     $('#messages ul').slideUp(300, function() {
//       $('#loading').show();
//       $.get(url, function(mailbox) {
//         $('#loading').hide();
//         $('#messages ul').html(mailbox);
//         fixMessageLinks();
//         $('#messages ul').slideDown(300);
//       });
//     });
//     $(this).parents('li').addClass('current');
//
//     e.stopPropagation();
//     return false;
//   });
// });