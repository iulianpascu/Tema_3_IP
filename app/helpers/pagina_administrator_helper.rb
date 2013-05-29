module PaginaAdministratorHelper
  def data_neterm
    Date.today
  end

  def data_term
    Date.today
  end

  def last_refresh(p)
    d = DataEvaluare.find_by_grupa_terminal(p)
    d ? d.last_refresh : '-'
  end
end
