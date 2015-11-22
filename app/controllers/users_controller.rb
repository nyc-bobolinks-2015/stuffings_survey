get '/' do
  if !logged_in?
    erb :'users/login'
  else
    redirect ('/surveys')
  end
end

get '/users' do
  erb :'/users/index'
end

get '/users/new' do
  erb :'/users/new'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/show'
end

get '/users/:id/edit' do
   @user = User.find(params[:id])
  erb :'/users/edit'
end


