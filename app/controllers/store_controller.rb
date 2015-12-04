class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize #Вы можете не допустить запуск этого фильтра (authorize) перед определенными экшнами с помощью skip_before_action

  def index   
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title) # order - сортирует, отобразим их в алфавитном порядке.
    end
  end
end
