class CreateQuestion < ActiveRecord::Migration[5.0]
	def change
		create_table :questions do |t|
			t.belongs_to :user, index: true
			t.string	:question_details
			t.string	:category
			t.timestamps
		end
		
		create_table :answers do |t|
			t.belongs_to :user, index: true
			t.belongs_to :question, index: true
			t.string	:answer_details
			t.timestamps
		end
	end
end
