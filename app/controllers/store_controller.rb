class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title) # order - сортирует, отобразим их в алфавитном порядке.
  end
end
