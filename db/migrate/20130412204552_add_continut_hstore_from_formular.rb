class AddContinutHstoreFromFormular < ActiveRecord::Migration
  def change
    add_column :formulare, :continut, :hstore
  end
end
