class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
    
  end

  def create
    @secret = Secret.new(secret_params)
    @secret.user = User.find_by_id(session[:user_id])
    @secret.user = current_user

    puts "current user is #{current_user}"
    puts "session user is #{session[:user_id]}"
    @secret.save
    redirect_to '/secrets'
  end

  def destroy
    puts "destroyed secret id is: #{params[:id]}"
    secret = Secret.find_by_id(params[:id])
    secret.destroy
    puts "destroyed secret id is: #{params[:id]}"
    redirect_to "/secrets"
  end

  private
  def secret_params
    params.require(:secret).permit(:content)
  end
end
