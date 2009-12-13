$(function() {
  $('textarea').tinymce({
    theme: "advanced",
    plugins: "safari,emotions",
    content_css: $('link[href*=tinymce\.css]').attr('href'),

    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align:    "left",
    theme_advanced_layout_manager:   "RowLayout",

    theme_advanced_containers: "controls,editor",
    theme_advanced_container_controls: "bold,italic,underline,strikethrough,|," +
                                       "forecolor,backcolor,|," +
                                       "numlist,bullist",
    theme_advanced_container_controls_align: "left",
    theme_advanced_container_editor: "mceEditor",
  });
});