class StoreController < ApplicationController
  def index
    @products = Product.order(:title) # order - сортирует, отобразим их в алфавитном порядке.
  end
end
