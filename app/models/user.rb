class User < ActiveRecord::Base
	has_secure_password

	has_many :parsecs
	has_many :comments
	has_many :parsec_user_votes
	has_many :comment_user_votes

	validates(:email, :name, uniqueness: true)
	validates(:email, :name, presence: true)
	validates(:password, length: { minimum: 5 })


	def calculate_nerd_score
		total = 0
		self.parsecs.each do |parsec|
			total += parsec.score
		end
		self.comments.each do |comment|
			total += comment.score
		end
		self.nerd_cred_score = total
		self.save	
	end

	def set_parsec_vote_log
		self.parsec_user_votes.map {|vote| vote.parsec_id }
	end

	def set_comment_vote_log
		self.comment_user_votes.map {|vote| vote.comment_id}
	end
	
end