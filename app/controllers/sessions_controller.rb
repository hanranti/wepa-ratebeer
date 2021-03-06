class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

#  def create
#    # haetaan usernamea vastaava käyttäjä tietokannasta
#    user = User.find_by username: params[:username]
#    
#    if user.nil?
#     redirect_to :back, notice: "User #{params[:username]} does not exist!"
#    else
#      # talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa)
#      session[:user_id] = user.id
#      # uudelleen ohjataan käyttäjä omalle sivulleen
#      redirect_to user, notice: "Welcome back!"
#    end
#  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end