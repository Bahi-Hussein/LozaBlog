class LoginsController < ApplicationController

	def new 
	end

	def create
		user = User.find_by(email: params[:email])

		if user and user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "Welcome"
		else
			flash[:danger]="email or password is not correct"
		end
		redirect_to articles_path
	end


	def destroy
		session[:user_id]=nil
		flash[:success] = "logged out"
		redirect_to root_path
	end
	
end
