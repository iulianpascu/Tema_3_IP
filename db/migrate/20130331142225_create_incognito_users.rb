class CreateIncognitoUsers < ActiveRecord::Migration
  def change
    create_table :incognito_users do |t|
      t.string :token
      t.integer :grupa_nume

      # t.timestamps
    end
  end
end
