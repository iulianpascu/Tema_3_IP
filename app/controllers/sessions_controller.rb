class SessionsController < ApplicationController

def new
end

def create



  if IncognitoUser.find_by_token(params[:sessions][:token])
    session[:user_token] = params[:sessions][:token]
#
    sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
    if sesiune

    	if sesiune.incepere_data > Time.now-600
					#redirect_to verificare_path
				flash[:alert] = "Ne pare rau dar proprietarul token-ului este deja logat :D"
    		render 'new'
			else

				sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
  			sesiune.destroy
				SesiuneActiva.create(incognito_user_token: params[:sessions][:token], incepere_data: Time.now)
		 		redirect_to verificare_path
			end

		else
		 SesiuneActiva.create(incognito_user_token: params[:sessions][:token], incepere_data: Time.now)
		 redirect_to verificare_path
		end
    							#flash[:notice] = "Logatu-te-ai in ceapa ta11!!!!1"
  else
    flash[:notice] = "An account associated with this token doesn't exist"
    render 'new'
  end

end


 def destroy

   sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
   sesiune.destroy
   session[:user_token] = nil
#   flash[:notice] = "Ai iesit cu ochii-n soare"
   redirect_to root_path
 end

end
