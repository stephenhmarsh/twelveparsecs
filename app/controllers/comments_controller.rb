class CommentsController < ApplicationController

	def show
		@comment = Comment.find(params[:id])
	end
		
	def create
		@user = current_user
		@parsec = Parsec.find(params[:comment][:parsec_id])
		@comment = Comment.create(comment_params)
		@comment.user_id = @user.id
		@comment.parsec_id = @parsec.id
		@comment.time = Time.now
		@comment.score = 0
		@comment.save
			redirect_to @parsec
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		@parsec = @comment.parsec
		@comment.body = params[:comment][:body]
		@comment.save
		redirect_to @parsec
	end

	def destroy
		@comment = Comment.find(params[:id])
		@parsec = @comment.parsec
		if @comment.destroy
			redirect_to @parsec
		else
			redirect_to edit_comment_path(@comment)
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end