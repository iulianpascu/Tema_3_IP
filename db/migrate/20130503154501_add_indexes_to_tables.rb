class AddIndexesToTables < ActiveRecord::Migration
  def up
    execute 'CREATE INDEX idx_grupe_nume ON grupe (nume)'
    execute 'CREATE INDEX idx_token ON incognito_users (token)'
  end

  def down
    execute 'DROP INDEX IF EXISTS idx_grupe_nume'
    execute 'DROP INDEX IF EXISTS idx_token'
  end
end
