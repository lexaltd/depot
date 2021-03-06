class CartsController < ApplicationController
  skip_before_action :authorize, only: [:create, :update, :destroy]#Вы можете не допустить запуск этого фильтра (authorize) перед определенными экшнами с помощью skip_before_action
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  # Оператор rescue_from перехватывает исключение
  # rescue_from - для перехвата всех ошибок ActiveRecord::RecordNotFound и что-то с ними делать(with: :invalid_cart).
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart 

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
   
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    #@cart.destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url }
      #format.html { redirect_to store_url, notice: 'Теперь ваша корзина пуста!' }
      # format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.js #чтобы отправить AJAX-запрос
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params[:cart]
    end

    def invalid_cart
      # Свойство  logger есть у каждого контроллера. 
      # В данном случае мы используем его для записи сообщения в регистрационный уровень error.
      # мы зарегистрируем этот факт во внутреннем журнале регистрации
      logger.error "Attempt to access invalid cart #{params[:id]}" 
      #logger.error "Попытка доступа к несуществующей корзине #{params[:id]}" 
      redirect_to store_url, notice: 'Invalid cart'
    end
end
