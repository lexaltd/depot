class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize #Вы можете не допустить запуск этого фильтра (authorize) перед определенными экшнами с помощью skip_before_action

  def index
    @products = Product.order(:title) # order - сортирует, отобразим их в алфавитном порядке.
  end
end
