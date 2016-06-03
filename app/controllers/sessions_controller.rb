class SessionsController < ApplicationController

  def create
      if auth_hash
        user = User.find_or_create_by_omniauth(auth_hash)
        log_in(user)
        redirect_to lists_path
      else
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to lists_path
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      end
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
