module WishlistsHelper

  def total_count(users)
    users.inject(0) { |total, user| total + user.wishlists.first.items.count }
  end

  def user_options(users)
    options = users.map { |user| [ "#{user.name}'s", user.id ] }
    if params[:id]
      options_for_select(options, params[:id].to_i)
    else
      options_for_select(options)
    end
  end
end
