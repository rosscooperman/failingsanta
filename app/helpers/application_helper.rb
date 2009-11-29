# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title)
    content_for :title do
      title
    end
  end

  # def menu_path(menu)
  #   return "#{menu}_index_path" if [:art].include?(menu)
  #   "#{menu}_path"
  # end
end
