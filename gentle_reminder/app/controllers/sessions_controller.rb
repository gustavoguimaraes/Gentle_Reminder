class SessionsController < ApplicationController

	def new 

	end 


	def create
		if params[:session]
			user = User.find_by_email(params[:session][:email].downcase)
				sign_in user
				redirect_to user_goals_path(user)
		else 
			user = User.from_omniauth(env["omniauth.auth"])
			github_data = Github.new(user)
			sign_in user 
			session[:user_id] = user.uid
			redirect_to user_goals_path(user)
		end 
	end 

	def destroy
		sign_out
		redirect_to root_url
	end 
end
