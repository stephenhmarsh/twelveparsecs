class ParsecUserVote < ActiveRecord::Base

	belongs_to :parsec
	belongs_to :user

	validates(:vote, numericality: {less_than: 2, only_integer: true})
	validates(:vote, numericality: {greater_than: -2, only_integer: true})

end