class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  # outsider cant destroy since not logged in
  def new

  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      if @user.try(:authenticate, params[:user][:password])
        session[:user_id] = @user.id
        redirect_to "/users/#{@user.id}"
      else 
        flash[:errors] =["Please enter a valid password"]
        redirect_to '/sessions/new'
      end
    else
      flash[:errors] = ["Please enter a valid email"]
      redirect_to '/sessions/new'
    end
 
    # result1 = User.find_by_email(params[:user][:email])
    # if result1 == nil
    #   redirect_to '/sessions/new'
    # else
    #   result2 = result1.try(:authenticate, params[:user][:password])
    #   if result2 == false
    #     redirect_to '/sessions/new'
    #   else
    #     session[:user_id] = result2.id
    #     redirect_to '/users/show'
    #   end
    # end
  end

  def destroy
    session[:user_id] = nil
    puts "from sessions destroy"
    redirect_to '/sessions/new'
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end

