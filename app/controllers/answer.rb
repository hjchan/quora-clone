##Answer
require 'byebug'

post '/answers/:id/upvote/:bool' do
  a_vote = AnswerVote.find_by(user_id: current_user.id, answer_id: params[:id])
  if params[:bool] == 'false'
    a_vote.update(upvote: false)
  else
    if a_vote == nil
      a_vote = AnswerVote.new(user_id: current_user.id, answer_id: params[:id], upvote: true, downvote: false)
    else
      a_vote.update(upvote: true, downvote: false)
    end
  end
  if a_vote.save
    return {success: true, upvote_count: AnswerVote.where(answer_id: params[:id], upvote: true).count, downvote_count: AnswerVote.where(answer_id: params[:id], downvote: true).count}.to_json
  else
    status 404
    return {error: "Something went wrong"}.to_json
  end
end

post '/answers/:id/downvote/:bool' do
  a_vote = AnswerVote.find_by(user_id: current_user.id, answer_id: params[:id])
  if params[:bool] == 'false'
    a_vote.update(downvote: false)
  else
    if a_vote == nil
      a_vote = AnswerVote.new(user_id: current_user.id, answer_id: params[:id], downvote: true, upvote: false)
    else
      a_vote.update(downvote: true, upvote: false)
    end
  end
  if a_vote.save
    return {success: true, upvote_count: AnswerVote.where(answer_id: params[:id], upvote: true).count, downvote_count: AnswerVote.where(answer_id: params[:id], downvote: true).count}.to_json
  else
    status 404
    return {error: "Something went wrong"}.to_json
  end
end