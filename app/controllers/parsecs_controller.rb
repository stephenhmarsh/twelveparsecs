class ParsecsController < ApplicationController

	before_action :authorize, only: [:edit, :update, :destroy]

	def index
		@user = current_user
		@parsecs = Parsec.order(score: :desc)
		@parsecs = @parsecs.first(100)
		if @user != nil
			@user_vote_log = @user.parsec_user_votes.map {|vote| vote.parsec_id}
		else
			@user_vote_log = []
		end
		@parsec_user_vote = ParsecUserVote.new
	end

	def show
		@user = current_user
		@parsec = Parsec.find(params[:id])
		@comment = Comment.new
		if @user != nil
			@user_vote_log = @user.parsec_user_votes.map {|vote| vote.parsec_id }
			@user_comment_vote_log = @user.comment_user_votes.map {|vote| vote.comment_id}
		else
			@user_vote_log = []
			@user_comment_vote_log = []
		end
		@parsec_user_vote = ParsecUserVote.new
		@comment_user_vote = CommentUserVote.new
		@associated_title = Parsec.omdb_search(@parsec.imdb_id)
		render :layout => "parsec_show"
	end

	def new
		if session[:user_id]
			@parsec = Parsec.new
			@search_results = Parsec.title_search(params[:search_term])
			if params[:associated_title]
				@associated_title = Parsec.omdb_search(params[:associated_title])
			else
				@associated_title={"imdbID" => "none"}
			end
		else
			redirect_to login_path
		end
	end

	def create
		@user = current_user
		@parsec = Parsec.create(parsec_params)
		@parsec.media_id = 0
		@parsec.user_id = @user.id
		@parsec.score = 0
		@parsec.time = Time.now
		if @parsec.save
			redirect_to @parsec
		else
			redirect_to new_parsec_path
		end
	end

	def edit
		@parsec = Parsec.find(params[:id])
	end

	def update
		@parsec = Parsec.find(params[:id])
		if @parsec.update(parsec_params)
			redirect_to @parsec
		else
			redirect_to edit_parsec_path(@parsec)
		end
	end

	def destroy
		@parsec = Parsec.find(params[:id])
		if @parsec.destroy
			redirect_to user_path(current_user)
		else
			redirect_to parsec_path(@parsec)
		end
	end

	def title_search
		@search_results = Parsec.title_search(params[:search_term])
			redirect_to action: 'new'
	end

	def search
		@search_results = Parsec.title_search(params[:search_term])
		if params[:associated_title]
			@associated_title = params[:associated_title]
		else
			@associated_title = nil
		end
	end

	private

	def parsec_params
		params.require(:parsec).permit(:title, :body, :imdb_id)
	end

	def authorize
		parsec = Parsec.find(params[:id])
		if parsec.user != current_user
			redirect_to parsec_path(parsec)
		end
	end

end