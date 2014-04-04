class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :parsec

	has_many :comment_user_votes, dependent: :destroy
	
end