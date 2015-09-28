module CurrentCart
  # Соответственно с помощью 
  # unclude мы добавляем метод из модуля к объекту класса, 
  # а с extend к самому классу.
  extend ActiveSupport::Concern # Чтоб было вместе - include и extend

  private

  def set_cart
      @cart = Cart.find(session[:cart_id]) # начинается с получения :cart_id из объекта session с последующей попыткой обнаружения корзины, соответствующей данному идентификатору
    
    #return render plain: session.inspect
    rescue ActiveRecord::RecordNotFound # Обработка исключительных ситуаций 
     # Если такая запись корзины не найдется, этот метод приступит к созданию нового объекта Cart, сохранит идентификатор созданной корзины в сессии, а затем вернет новую корзину.     
      @cart = Cart.create
      session[:cart_id] = @cart.id
  end
end