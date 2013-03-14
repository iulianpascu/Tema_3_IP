class SessionsController < ApplicationController


 def new
 end

 def create


   user = User.find_by_token(params[:sessions][:token])
     if user 
       sign_in user
       redirect_to '/users'
     elsif (!user)
       flash[:notice] = "An account associated with this token doesn't exist"
       render 'new'
       else 
         flash[:notice] = "You entered the wrong token"
         render 'new'
     end

 end


 def destroy
 end

end
