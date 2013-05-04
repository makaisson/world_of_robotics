class AddProductsTable < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title,           null: false
      t.string  :description,     null: true
      t.integer :amount_in_cents, null: true
      t.timestamps
    end
  end
end
