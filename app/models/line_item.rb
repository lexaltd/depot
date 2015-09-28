class LineItem < ActiveRecord::Base
  belongs_to :product #принадлежит product
  belongs_to :cart #принадлежит cart
end
