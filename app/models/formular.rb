class Formular < ActiveRecord::Base
  attr_accessible :continut
  has_many :asocieri

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end

  def intrebari_radio
    require 'json'
    j = JSON.load self.continut
    return [] unless j['chestionar']
    
    continuturi = j["chestionar"]
    raspunsuri = []
    continuturi.each_with_index do |parent, qindex|
      intrebare = parent["intrebare"]
      if intrebare
        if intrebare.count > 1 and intrebare.first['enunt']
          raspunsuri << {index: qindex + 1, text: intrebare.first['enunt']}
        end
      end
    end

    return raspunsuri
  end

  def intrebari_libere
    require 'json'
    j = JSON.load self.continut
    return [] unless j['chestionar']
    
    continuturi = j["chestionar"]
    raspunsuri = []
    continuturi.each_with_index do |parent, qindex|
      intrebare = parent["intrebare"]
      if intrebare
        if intrebare.count == 1 and intrebare.first['enunt']
          raspunsuri << {index: qindex + 1, text: intrebare.first['enunt']}
        end
      end
    end

    return raspunsuri
  end
end
