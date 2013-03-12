class AddCookieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cookie, :string
    add_index  :users, :cookie
  end
end
