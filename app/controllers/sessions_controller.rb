class SessionsController < ApplicationController

def new
end

def create


   
  if IncognitoUser.find_by_token(params[:sessions][:token])
    session[:user_token] = params[:sessions][:token]
    redirect_to   sign_in_path flash[:notice] = "Logatu-te-ai in ceapa ta11!!!!1"
  else
    flash[:notice] = "An account associated with this token doesn't exist"
    render 'new'
  end

end


 def destroy
   session[:user_token] = nil
   flash[:notice] = "Ai iesit cu ochii-n soare"
   redirect_to root_path
 end

end
