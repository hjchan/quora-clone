class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :user
	has_many :answers
  has_many :question_votes

	validates :question_details, presence: true
	validates :category, presence: true
end
