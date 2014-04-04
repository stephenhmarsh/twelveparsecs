class CommentUserVotesController < ApplicationController

	before_action :authorize, only: [:create, :update, :destroy]
	before_action :voter_id, only: [:create]

	def create
		@vote = CommentUserVote.new(vote_params)
		@vote.user_id = current_user.id
		@vote.time = Time.now
		@vote.save

		@comment = Comment.find(@vote.comment_id)
		@comment.score = @comment.comment_user_votes.inject(0) {|total, vote_obj| total + vote_obj.vote}
		if @comment.save
			redirect_to :back
		end
	end

	def update
		@vote = CommentUserVote.find(params[:id])
		@comment = Comment.find(@vote.comment_id)
		@vote.vote = params[:comment_user_vote][:vote]
		@vote.save
		@comment.score = @comment.comment_user_votes.inject(0) {|total, vote_obj| total + vote_obj.vote}
		if @comment.save
			redirect_to :back
		end
	end

	def destroy
		@vote = CommentUserVote.find(params[:id])
		@vote.destroy

		@comment = Comment.find(@vote.comment_id)
		@comment.score = @comment.comment_user_votes.inject(0) {|total, vote_obj| total + vote_obj.vote}
		if @comment.save
			redirect_to :back
		end
	end

	private
	def vote_params
		params.require(:comment_user_vote).permit(:vote, :comment_id)
	end

	def authorize
		unless current_user
			redirect_to :back
		end
	end

	def voter_id
		comment = Comment.find(params["comment_user_vote"][:comment_id])
		if current_user == comment.user
			redirect_to parsec_path(comment.parsec, message: "You can't vote on your own comment, bro.")
		end
	end

end