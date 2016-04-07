class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by email: params[:login][:email]

  	if user && user.authenticate(params[:login][:password])
  		session[:user_id] = user.id
  		redirect_to root_path, notice: 'Successfully logged in'
  	else
  		flash.now.alert = 'Invalid email or password'
  		render :new
  	end
  end

  def create_google
    begin
      user = User.from_omniauth(request.env['omniauth.auth']) 
      logger.debug request.env['omniauth.auth']
      session[:user_id] = user.id
      flash.now[:success] = "Welcome, #{user.name}!"
    rescue
      flash.now[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, notice: 'Successfully logged out'
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation, :uid, :provider, :name, :location, :image_url, :url
  end
  
end
