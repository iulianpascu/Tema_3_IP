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
end
