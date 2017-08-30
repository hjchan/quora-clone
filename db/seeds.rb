require 'csv'

CSV.foreach("db/user.csv") do |row|
  User.create(full_name: row[0], email: row[1], password: row[2], password_confirmation: row[3])
end

CSV.foreach("db/question.csv") do |row|
  Question.create(user_id: row[0], question_details: row[1], category: row[2], title: row[3])
end

CSV.foreach("db/answer.csv") do |row|
  Answer.create(user_id: row[0], question_id: row[1], answer_details: row[2])
end

CSV.foreach("db/questionvote.csv") do |row|
  QuestionVote.create(user_id: row[0], question_id: row[1], upvote: row[2], downvote: row[3])
end

CSV.foreach("db/answervote.csv") do |row|
  AnswerVote.create(user_id: row[0], answer_id: row[1], upvote: row[2], downvote: row[3])
end

# CSV.open("db/question.csv", "wb") do |csv|
#   Question.all.each do |q|
#     csv << [q.user_id, q.question_details, q.category, q.title]
#   end
# end

# CSV.open("db/questionvote.csv", "wb") do |csv|
#   QuestionVote.all.each do |q|
#     csv << [q.user_id, q.question_id, q.upvote, q.downvote]
#   end
# end

# CSV.open("db/answervote.csv", "wb") do |csv|
#   AnswerVote.all.each do |q|
#     csv << [q.user_id, q.answer_id, q.upvote, q.downvote]
#   end
# end

# CSV.open("db/answer.csv", "wb") do |csv|
#   Answer.all.each do |q|
#     csv << [q.user_id, q.question_id, q.answer_details]
#   end
# end