class CreateEvaluareCompletate < ActiveRecord::Migration
  def change
    create_table :evaluare_completate do |t|
      t.integer :evaluare_disponibila_id
      t.string :incognito_user_token
      t.xml :continut
      t.integer :timp
    end
  end
end
