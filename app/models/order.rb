class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy 
  # показав, что все товарные позиции, принадлежащие заказу, 
  # должны быть уничтожены при уничтожении заказа:
 
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  
  def add_line_items_from_cart(cart) 
    cart.line_items.each do |item|      
      item.cart_id = nil # чтобы товарная позиция не исчезла при удалении корзины.
      line_items << item # товарную позицию мы добавим к коллекции line_items для заказа.
    end
  end

end
