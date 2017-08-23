get '/' do
	@questions = Question.all
  	erb :"static/index"
end

### User

get '/user/new' do
  	erb :"users/signup"
end

get '/user' do
	erb :"users/profile"
end

post '/user' do
	user = User.new(params[:user])
	if user.save
		session[:id] = user.id
		redirect "/user"
	else
		@user = user
		erb :"users/signup"
	end
end

get '/user/signin' do
	erb :"users/signin"
end

post '/user/signin' do
	user = User.find_by(email: params[:email])
	if user.nil?
		@error = "Wrong email!"
		erb :"users/signin"
	else
		login = user.authenticate(params[:password])
		if login == false
			@error = "Wrong password!"
			erb :"users/signin"
		else
			session[:id] = user.id
			redirect "/user"
		end
	end
end

get '/user/signout' do
	session.clear
	redirect '/'
end

### Question

get '/question' do
	@questions = Question.all
	erb :"questions/index"
end

get '/question/new' do
	erb :"questions/new"
end

post '/question' do
	params[:question][:user_id] = session[:id]
	question = Question.new(params[:question])
	if question.save
		redirect "/question"
	else
		@question = question
		erb :"/"
	end
end

get '/question/:id' do
	@question = Question.find(params[:id])
	erb :"questions/question"
end

post '/question/:id' do
	answer = Answer.new(question_id: params[:id], user_id: session[:id], answer_details: params[:answer])
	answer.save
	@question = Question.find(params[:id])
	erb :"questions/question"
end