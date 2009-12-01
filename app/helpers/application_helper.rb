# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title)
    content_for :title do
      title
    end
  end

  def menu_item(name, path)
    "<li>#{link_to(name, path)}</li>"
  end
end
