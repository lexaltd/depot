class AddQuantityToLineItems < ActiveRecord::Migration
  # Rails ищет соответствие двум шаблонам: add_XXX_to_TABLE и remove_XXX_from_TABLE, 
  #       где значение XXX игнорируется. 
  # Значение имеет список имен столбцов и типов данных, появляющийся после имени миграции.
  def change
    add_column :line_items, :quantity, :integer, default: 1
  end
end
