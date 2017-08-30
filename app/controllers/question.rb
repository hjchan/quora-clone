### Question

require 'byebug'

get '/questions' do
  @questions = Question.paginate(page: params[:page])
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

get '/questions/category/:name' do
  @category = params[:name]
  @questions = Question.where(category: params[:name])
  erb :"questions/index"
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

post '/questions/:id/upvote/:bool' do
  q_vote = QuestionVote.find_by(user_id: current_user.id, question_id: params[:id])
  if params[:bool] == 'false'
    q_vote.update(upvote: false)
  else
    if q_vote == nil
      q_vote = QuestionVote.new(user_id: current_user.id, question_id: params[:id], upvote: true, downvote: false)
    else
      q_vote.update(upvote: true, downvote: false)
    end
  end
  if q_vote.save
    return {success: true, upvote_count: QuestionVote.where(question_id: params[:id], upvote: true).count, downvote_count: QuestionVote.where(question_id: params[:id], downvote: true).count}.to_json
  else
    status 404
    return {error: "Something went wrong"}.to_json
  end
end

post '/questions/:id/downvote/:bool' do
  q_vote = QuestionVote.find_by(user_id: current_user.id, question_id: params[:id])
  if params[:bool] == 'false'
    q_vote.update(downvote: false)
  else
    if q_vote == nil
      q_vote = QuestionVote.new(user_id: current_user.id, question_id: params[:id], downvote: true, upvote: false)
    else
      q_vote.update(downvote: true, upvote: false)
    end
  end
  if q_vote.save
    return {success: true, upvote_count: QuestionVote.where(question_id: params[:id], upvote: true).count, downvote_count: QuestionVote.where(question_id: params[:id], downvote: true).count}.to_json
  else
    status 404
    return {error: "Something went wrong"}.to_json
  end
end