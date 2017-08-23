class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belongs_to :user
	has_many :answers

	validates :question_details, presence: true
	validates :category, presence: true
end
