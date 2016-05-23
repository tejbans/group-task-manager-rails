class SessionsController < ApplicationController

  def create
      user = User.find_or_create_by(:email => auth['info']['email']) do |user|
        user.email = auth['info']['email']
        user.password = SecureRandom.hex
      end
  session[:user_id] = user.try(:id)
  redirect_to lists_path
  end

  def auth
    request.env['omniauth.auth']
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
