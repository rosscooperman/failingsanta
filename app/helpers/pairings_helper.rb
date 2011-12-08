module PairingsHelper

  def pairing_select_options(selected)
    @pairing_select_users ||= User.all
    options_from_collection_for_select(@pairing_select_users, :id, :name, selected)
  end
end
