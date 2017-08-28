class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :full_name, presence: true
	validates :email,
			uniqueness: true,
			format: {with: /@\w{2,}\./,
				message: "wrong format"}
	validates :password, length: { minimum: 6 }
	has_secure_password

	has_many :questions
	has_many :answers
	has_many :question_votes
	has_many :answer_votes
end
