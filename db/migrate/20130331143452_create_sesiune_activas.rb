class CreateSesiuneActivas < ActiveRecord::Migration
  def change
    create_table :sesiune_active do |t|
      t.string :incognito_user_token
      t.datetime :incepere_data

      # t.timestamps
    end
  end
end
