class AddSpecializareToGrupa < ActiveRecord::Migration
  def change
    add_column :grupe, :specializare, :string
    add_column :grupe, :formular_id, :integer
    add_column :grupe, :domeniu , :string
  end
end
