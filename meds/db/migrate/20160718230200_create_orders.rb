class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :category
      t.string :state

      t.timestamps
    end
  end
end
