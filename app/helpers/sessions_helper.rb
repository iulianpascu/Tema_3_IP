module SessionsHelper
  def sign_in(user)
    cookies.permanent[:cookie] = user.cookie
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_cookie(cookies[:cookie])
  end

  def signed_in?
     !current_user.nil?
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:cookie)
  end
end
