class AddStuffToFormular < ActiveRecord::Migration
  def change
    add_column :formulare, :an, :integer
    add_column :formulare, :semestru, :integer
    add_column :formulare, :stadiu, :string
    add_column :formulare, :specializare, :string
    add_column :formulare, :tip_curs, :string, {limit: 1, default: 'c'}
  end
end
