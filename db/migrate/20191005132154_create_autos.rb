class CreateAutos < ActiveRecord::Migration
  def change
    create_table :autos do |t|
      t.string :year
      t.string :make
      t.string :model  
      t.string :price
      t.integer :owner_id
    end
  end
end
