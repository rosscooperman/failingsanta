var JSelect = {
  collectValues: function(element) {
    var options = []
    $(element).children('option').each(function() {
      var option = {
        value:    $(this).val(),
        text:     $(this).text(),
        selected: $(this).attr('selected')
      };
      options.push(option);
    });
    return options;
  },

  selectedOption: function(options) {
    var selected = {};
    jQuery.each(options, function() {
      if (this.selected) {
        selected = this;
        return false;
      }
    });
    return selected;
  },

  generateList: function(options) {
    var list = '<ul style="display: none">';
    jQuery.each(options, function() {
      list += '<li id="' + this.value + '"';
      if (this.selected) list += ' class="selected"';
      list += '>' + this.text + '</li>';
    });
    return list + '</ul>'
  },

  generateContent: function(element) {
    var options  = JSelect.collectValues(element);
    var list     = JSelect.generateList(options);
    var selected = JSelect.selectedOption(options);
    return '<div class="jselect"><div class="title">' + selected.text +
           '</div>' + list + '<input type="hidden" name="' + $(element).attr('name') +
           '" value="' + selected.value + '" /></div>';
  },

  toggleOver: function(event) {
    $(this).toggleClass('title-over');
  },

  selectOption: function(event) {
    $(this).addClass('selected');
    $(this).siblings('li').removeClass('selected');
  },

  resetSelection: function(element) {
    var currValue = $(element).find('input[type=hidden]').val();

    $(element).find('li').removeClass('selected');
    $(element).find('li#' + currValue).addClass('selected');
  },

  close: function(element) {
    var list = $(element).find('ul');
    if (list.is(':visible')) {
      list.slideUp(125, function() { JSelect.resetSelection(element); });
    }
  },

  closeAll: function(event) {
    $('.jselect').each(function() {
      JSelect.close(this);
    });
  },

  doSelect: function(event) {
    var oldValue = $(this).parents('.jselect').find('input[type=hidden]').val();
    var newValue = $(this).attr('id');

    $(this).parents('.jselect').find('.title').text($(this).text());
    JSelect.close($(this).parents('.jselect'));
    $(this).parents('.jselect').find('input[type=hidden]').val(newValue);
    if (oldValue != newValue) {
      $(this).parents('.jselect').find('input[type=hidden]').trigger('change');
    }
    event.stopImmediatePropagation();
  },

  handleClick: function(event) {
    if ($(this).parent().find('ul').is(':visible')) {
      JSelect.close($(this).parent());
    }
    else {
      $(this).parent().find('ul').slideDown(125);
      $(this).parent().find('li').bind('click', JSelect.doSelect);
    }
    event.stopImmediatePropagation();
  },

  processOptions: function(jselect, options) {
    if (options.change) {
      jselect.find('input[type=hidden]').bind('change', options.change);
    }
  },

  fixTitle: function(jselect) {
    // adjust the width to slightly more than the maximum width item in the list
    var width = jselect.find('ul').width();
    jselect.find('.title').width(width);

    // make sure what's selected is what should be selected
    //TODO make this more generalized
    var selected = $.bbq.getState('list', true);
    if (selected != undefined) {
      var selectedElement = jselect.find('li#' + selected);
      jselect.find('.title').html(selectedElement.html());
      jselect.find('input[type=hidden]').val(selected);
      selectedElement.trigger('mouseenter');
    }
  },

  setTimer: function(event) {
    $(this).oneTime(500, function() {
      JSelect.close(this);
    });
  },

  clearTimer: function(event) {
    $(this).stopTime();
  }
};

jQuery.fn.jselect = function(options) {
  this.each(function() {
    if ($(this).is('select')) {
      var parent = $(this).parent();
      var newContent = JSelect.generateContent(this);
      $(this).replaceWith(newContent);

      parent.find('.jselect').mouseleave(JSelect.setTimer);
      parent.find('.jselect').mouseenter(JSelect.clearTimer);
      parent.find('.jselect .title').bind('mouseenter mouseleave', JSelect.toggleOver);
      parent.find('.jselect .title').click(JSelect.handleClick);
      parent.find('.jselect li').mouseenter(JSelect.selectOption)
      $(document).click(JSelect.closeAll);

      JSelect.processOptions(parent.find('.jselect'), options);
      JSelect.fixTitle(parent.find('.jselect'));
    }
  });

  return this;
};
