class UsersController < ApplicationController
  skip_before_action :require_login, except: [:edit, :show]
  # skip_before_action :require_login, except: [:edit, :update]
  def new
  end

  def show
    # verify_user - we dont need this since using current user anyways
    @individual_secrets = current_user.secrets
    puts "individual secrets are : #{current_user.secrets}"
    @secrets_liked = current_user.secrets_liked
    puts "individual secrets are : #{current_user.secrets_liked}"
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    
    if @user.valid?
      @user.save
      puts "User is: #{@user}"

      session[:user_id] = @user.id
      puts "session id is #{session[:user_id]}"
      
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users/new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  # def verify_user
  #   if ! params[:id] == session[:user_id]
  #     redirect_to 'sessions/new'
  #   end
  # end 

end
