class UsersController < ApplicationController

	before_action :authenticate, only: [:edit, :update, :destroy]

	def index
		@users = User.all
		@users.each {|user| user.calculate_nerd_score}
		@users = @users.order(nerd_cred_score: :desc)
	end

	def show
		@user = User.find(params[:id])
		@user.calculate_nerd_score
	end

	def new
		@user = User.new
	end

	def create
		date = Time.now
		date = "#{date.year}-#{date.month}-#{date.day}"	
		@user = User.new(user_params)
		@user.nerd_cred_score = 0		
		@user.admin = false
		@user.date_joined = date
		if @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to users_path
		else
			redirect_to edit_user_path(@user)
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar_url, :nerd_cred_score, )
	end

end