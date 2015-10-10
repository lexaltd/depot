class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product #принадлежит product
  belongs_to :cart #принадлежит cart

  def total_price
    product.price * quantity
  end
end
