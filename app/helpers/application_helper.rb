# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title)
    content_for :title do
      title
    end
  end

  def menu_item(name, path)
    content_tag :li, link_to(name, path)
  end

  def errors_on(obj)
    render(partial: 'layouts/errors', object: obj, as: :obj) unless obj.errors.empty?
  end
end
