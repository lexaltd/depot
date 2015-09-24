class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2 # чтобы у нее было восемь цифр в значимой части и две цифры после десятичного знака.

      t.timestamps null: false
    end
  end
end
