class AddDetaliiToGrupa < ActiveRecord::Migration
  def change
    add_column :grupe, :an, :integer
    add_column :grupe, :serie, :integer
  end
end
