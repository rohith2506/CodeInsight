class UsersController < ApplicationController
	include ApplicationHelper
	def new
		@user=User.new
	end

	def create
		@user=User.new(user_params)
		if @user.save
			#handle a successful save
		else
			render 'new'
		end
	end

	def show
		@user=User.find(params[:id])
	end
	def edit
		$username=params[:username]
		@user=User.find_by(username:params[:username])
	end

	def update
		@user=User.find(params[:id])
		if @user.update_attributes(user_params_for_update)
			flash[:success]='Profile updated'
			redirect_to @user
		else
			render 'edit'
		end
	end

	private

		def user_params
			params.require(:user).permit(:username,:name,:email,:password,:password_confirmation)
		end

		def user_params_for_update
			params.require(:user).permit(:name,:email,:password,:password_confirmation)
		end
end
