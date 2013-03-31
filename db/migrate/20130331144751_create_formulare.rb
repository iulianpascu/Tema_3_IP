class CreateFormulare < ActiveRecord::Migration
  def change
    create_table :formulare do |t|
      t.xml :continut
    end
  end
end
