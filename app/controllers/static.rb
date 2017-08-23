get '/' do
	@questions = Question.all
  	erb :"static/index"
end

### User

get '/users/new' do
  	erb :"users/signup"
end

get '/users' do
	@users = User.all
	erb :"users/index"
end

post '/users' do
	user = User.new(params[:user])
	if user.save
		session[:id] = user.id
		redirect "/user"
	else
		@user = user
		erb :"users/signup"
	end
end

get '/users/signin' do
	erb :"users/signin"
end

post '/users/signin' do
user = User.find_by(email: params[:email])
	if user.nil?
		@error = "Wrong email!"
		erb :"users/signin"
	else
		if !user.authenticate(params[:password])
			@error = "Wrong password!"
			erb :"users/signin"
		else
			session[:id] = user.id
			redirect "/users/#{session[:id]}"
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

### Question

get '/questions' do
	@questions = Question.all
	erb :"questions/index"
end

get '/questions/new' do
	erb :"questions/new"
end

post '/questions' do
	params[:question][:user_id] = session[:id]
	question = Question.new(params[:question])
	if question.save
		redirect "/questions"
	else
		@question = question
		erb :"/"
	end
end

get '/questions/:id' do
	@question = Question.find(params[:id])
	erb :"questions/question"
end

post '/questions/:id/answers' do
	answer = Answer.new(question_id: params[:id], user_id: session[:id], answer_details: params[:answer])
	answer.save
	redirect "/questions/#{params[:id]}"
end