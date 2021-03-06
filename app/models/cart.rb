class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy # имеет много line_items
   #dependent: :destroy #Удаление связанных объектов (из бд line_items)


  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    
    current_item
  end 

  def remove_product(item_id)
    current_item = line_items.find_by(id: item_id)

    if current_item
      current_item.quantity -= 1
      current_item
    end    
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
    # line_items.to_a.sum  do |item|
    #   item.total_price 
    # end

    #line_items.to_a.sum(&:total_price)
  end  
end
