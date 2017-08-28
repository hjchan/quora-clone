get '/' do
	@questions = Question.all
  	erb :"static/index"
end