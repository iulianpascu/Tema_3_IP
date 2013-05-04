module ApplicationHelper
  def semestru_curent_hash
    { an: (Date.today.year - (Date.today.month > 6 ? 0 : 1) ),
      semestru: (Date.today.month > 6 ? 1 : 2) }
  end

  def an_universitar_curent 
    Date.today.year - (Date.today.month > 6 ? 0 : 1)
  end

  def semestru_curent
    Date.today.month > 6 ? 1 : 2
  end
end
