### User
require 'byebug'

get '/users/new' do
    erb :"users/signup"
end

get '/users' do
  @users = User.all
  erb :"users/index"
end

post '/users/new' do
  user = User.new(params[:user])
  if user.save
    session[:id] = user.id
    return {success: true, url: "/users/#{session[:id]}"}.to_json
  else
    error = user.errors.messages
    error = "#{error.first[0].to_s}: #{error.first[1][0].to_s}"
    return {success: false, msg: error}.to_json
  end
end

get '/users/signin' do
  erb :"users/signin"
end

post '/users/signin' do
  user = User.find_by(email: params[:email])
  if user.nil?
    error = "Wrong email!"
    return {success: false, msg: error}.to_json
  else
    if !user.authenticate(params[:password])
      error = "Wrong password!"
      return {success: false, msg: error}.to_json
    else
      session[:id] = user.id
      return {success: true, url: back}.to_json
    end
  end
end

get '/users/signout' do
  session[:id] = nil
  redirect '/'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :"users/profile"
end
