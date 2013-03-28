class CreateTokenUsers < ActiveRecord::Migration
  def change
    create_table :token_users do |t|
      t.string :grupa
      t.string :token

      t.timestamps
    end
  end
end
