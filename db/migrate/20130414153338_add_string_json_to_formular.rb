class AddStringJsonToFormular < ActiveRecord::Migration
  def change
    add_column :formulare, :continut, :text
  end
end
