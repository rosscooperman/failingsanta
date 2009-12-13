$(function() {
  var baseUrl = $('script[src*=application.js]').attr('src');
  baseUrl = baseUrl.replace(/javascripts\/application\.js(\?\d+)?$/, '');
  $('textarea').tinymce({
    extended_valid_elements: "img[src|alt|mce_src|title|border]",
    document_base_url: baseUrl,
    relative_urls: false,
    theme: "advanced",
    plugins: "safari,emotions",
    content_css: $('link[href*=tinymce\.css]').attr('href'),

    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align:    "left",
    theme_advanced_layout_manager:   "RowLayout",

    theme_advanced_containers: "controls,editor",
    theme_advanced_container_controls: "bold,italic,underline,strikethrough,|," +
                                       "forecolor,backcolor,|," +
                                       "numlist,bullist,|," +
                                       "emotions",
    theme_advanced_container_controls_align: "left",
    theme_advanced_container_editor: "mceEditor",
  });
});