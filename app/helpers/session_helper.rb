helpers do
  def current_user
    User.find_by_id(session[:user_id]) #returns nil when doesn't find record
  end

  def logged_in?
    current_user != nil
  end
end
