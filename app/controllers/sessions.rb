post '/users/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect ('/surveys')
  else
    # include error message that user information isn't correct
    erb :'/users/index'
  end
end


post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect ("/surveys")
  else
    erb :'/users/new'
  end
end


get '/users/logout' do
  session.clear
  redirect("/")
end


