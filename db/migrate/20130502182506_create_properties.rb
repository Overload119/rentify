class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :bedroom_count
      t.decimal :latitude
      t.decimal :longitude
      t.timestamps
    end
  end
end
