class AddTokenDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token_digest, :string
  end
end
