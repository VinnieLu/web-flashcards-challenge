
get '/profile' do 
	@rounds = Round.where(user_id: params[:id]).order(:deck_id)
	@user = User.find_by(user_id: params[:id])
	erb :profile
end

get '/register' do
	@error = "Username already exists." if params['e']
 erb :register
end

post '/register' do
 @user = User.authenticate(params['username'])
 if @user 
 	redirect '/register?e=1'
 else
 	@user = User.create(params)
 end
 redirect '/'
end

get '/login' do
	@error = "Invalid username or password" if params['e']
 erb :login
end


post '/login' do
@user = User.authenticate(params['username'])
 if @user && @user.password == params['password']
   	session[:user_id] = @user.id
    redirect '/profile'
 else
	redirect '/login?e=1'
 end
end

get '/profile' do
	session[:user_id]
 	erb :profile
end

#  before '/profile/' do
#  if session[:user_id] == nil
#     redirect '/login'
#   end
#  end


# get '/restricted_area' do

#   session[:user_id]
#  erb :restricted_area
# end

get '/logout' do
 session[:user_id] = nil
 redirect '/login'
end