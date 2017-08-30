get '/' do
  @questions = Question.paginate(page: params[:page])
 	erb :"static/index"
end