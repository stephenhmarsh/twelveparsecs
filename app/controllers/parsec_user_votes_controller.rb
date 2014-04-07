class ParsecUserVotesController < ApplicationController

	before_action :authorize, only: [:create, :update, :destroy]
	before_action :voter_id, only: [:create]

	def create
		@vote = ParsecUserVote.new(vote_params)
		@vote.user_id = current_user.id
		@vote.time = Time.now
		@vote.save

		@parsec = Parsec.find(@vote.parsec_id)
		@parsec.score = @parsec.update_score
		if @parsec.save
			redirect_to :back
		end
	end

	def update
		@vote = ParsecUserVote.find(params[:id])
		@parsec = Parsec.find(@vote.parsec_id)
		@vote.vote = params[:parsec_user_vote][:vote]
		@vote.save
		@parsec.score = @parsec.update_score
		if @parsec.save
			redirect_to :back
		end
	end

	def destroy
		@vote = ParsecUserVote.find(params[:id])
		@vote.destroy

		@parsec = Parsec.find(@vote.parsec_id)
		@parsec.score = @parsec.update_score
		if @parsec.save
			redirect_to :back
		end
	end

	private
	def vote_params
		params.require(:parsec_user_vote).permit(:vote, :parsec_id)
	end

	def authorize
		unless current_user
			redirect_to :back
		end
	end

	def voter_id
		parsec = Parsec.find(params["parsec_user_vote"][:parsec_id])
		if current_user == parsec.user
			redirect_to parsec_path(parsec, message: "You can't vote on your own Parsec, bro.")
		end
	end

end