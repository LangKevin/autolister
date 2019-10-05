class CreateAutoBuyers < ActiveRecord::Migration
  def change
    create_table :auto_buyers do |t|
     t.integer :auto_id
     t.integer :buyer_id
   end
  end
end
