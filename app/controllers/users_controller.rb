class UsersController < ApplicationController
  def new
  	@user = User.new params[:user]
  end

  def create
  	@user = User.new user_params

  	if @user.save
  		redirect_to root_path, notice: 'Successfully created user.'
  	else
  		render :new
  	end
  end

  def show
    @user = User.find(params[:id])

    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def edit
    @user =  User.find(params[:id])
    if current_user.id != @user.id
      redirect_to @user
    end    
  end

  def change_password
    @user =  User.find(params[:id])
    if current_user.id != @user.id
      redirect_to @user
    end    
  end

    def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
  	params.require(:user).permit :email, :password, :password_confirmation, :uid, :provider, :name, :location, :image_url, :url
  end
end
