class AddDetaliiToProfesor < ActiveRecord::Migration
  def change
    add_column :profesori, :departament, :string
  end
end
