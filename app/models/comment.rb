class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :parsec

	has_many :comment_user_votes, dependent: :destroy

	def update_score
		self.comment_user_votes.inject(0) {|total, vote_obj| total + vote_obj.vote}
	end
	
end