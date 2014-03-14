class SessionsController < ApplicationController

	def new
	end

	def create
		user=User.find_by(username: params[:session][:username].downcase)
		if(user && user.authenticate(params[:session][:password]))
			sign_in user
			#as of now
			flash[:success]="You have been successfully signed in"
			redirect_to root_url
		else
			flash.now[:error]="Invalid username/password combination"
			render 'new'
		end
	end

	def destroy
		sign_out
		flash[:success]="u ve been logged out"
		redirect_to root_url
	end

end
