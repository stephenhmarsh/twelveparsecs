class Parsec < ActiveRecord::Base

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :parsec_user_votes, dependent: :destroy

	def update_score
		self.parsec_user_votes.inject(0) {|total, vote_obj| total + vote_obj.vote}
	end

	def self.title_search(search_term)
		if search_term != nil
			if search_term.split(' ').length > 1
				search_term = search_term.split(' ')
				search_term = search_term.join('+')
			end
			raw_results = httparty_get("http://www.imdb.com/xml/find?json=1&nr=1&tt=on&q=#{search_term}")
			results = parse_json(raw_results)
			return results
		end
	end

	def self.omdb_search(search_term)
			results = httparty_get("http://www.omdbapi.com/?i=#{search_term}")
			results = parse_json(results)
			return results
		end

	def self.httparty_get(url)
		return HTTParty.get(url)
	end

	def self.parse_json(response)
		return JSON.parse(response)
	end

end