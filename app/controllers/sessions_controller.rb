class SessionsController < ApplicationController
	def create
		if params[:username] == 'admin' && params[:password] == 'password'
			flash[:notice] = 'Login successfully.'
			session[:current_user] = 'admin'
			redirect_to root_url
		else
			render :action => "new"
		end
	end
	
	def destroy
		flash[:notice] = 'Logged out.'
		session[:current_user] = nil
		redirect_to root_url
	end
	
	def new
		
	end
end
