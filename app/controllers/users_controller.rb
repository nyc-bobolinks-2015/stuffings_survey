get '/' do
  redirect '/users'
end

get '/users' do
  erb :'/users/index'
end

post '/users/index' do
  @user = User.find_by(email: params[:email], password: params[:password])
  if @user && @user.password == params[:user] [:password]
    session[:user_id] = @user.id
    redirect ('/surveys')
  else
    erb :'/users'
  end
end

get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    redirect ("/surveys")
  else
    erb :'/users/new'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/show'
end

get '/users/:id/edit' do
   @user = User.find(params[:id])
  erb :'/users/edit'
end

get '/users/logout' do
  session.clear
  redirect("/")
end
