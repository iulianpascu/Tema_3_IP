module ApplicationHelper
  def comentarii_disponibile(curs_dep, profesor_id)
    if profesor_id == session[:user_signed][:uid] 
      true
    elsif session[:user_signed][:sef] and curs_dep == session[:user_signed][:departament] 
      true
    elsif session[:user_signed][:role] == 'admin'
      true
    else
      false
    end
  end
end
