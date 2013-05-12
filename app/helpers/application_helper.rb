module ApplicationHelper
  def comentarii_disponibile(curs_dep, profesor_id)
    logger.info "#{curs_dep} #{Profesor.where(id: session[:user_signed][:uid]).pluck(:departament).first}"
    if profesor_id == session[:user_signed][:uid] 
      true
    elsif session[:user_signed][:sef] && curs_dep == Profesor.where(id: session[:user_signed][:uid]).pluck(:departament).first
      true
    elsif session[:user_signed][:role] == 'admin'
      true
    else
      false
    end
  end
end
