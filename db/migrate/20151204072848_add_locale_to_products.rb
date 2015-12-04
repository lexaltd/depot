class AddLocaleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :locale, :string
  end

  # def up
  #   add_column :products, :locale, :string
  # end

  # def down
  #   remove_column :products, :locale
  # end

end
