class CreateActivareButons < ActiveRecord::Migration
  def change
    create_table :activare_butons do |t|
      t.string :data_inceput
      t.string :data_sf

      t.timestamps
    end
  end
end
