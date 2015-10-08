class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :destroy] # вызвать (set_cart) этот метод перед create 

  before_action :set_line_item, only: [:show, :edit, :update, :destroy] # вызвать (set_line_item) этот метод только перед [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    #@line_item = LineItem.new(line_item_params)

    product = Product.find(params[:product_id])
    #@line_item = @cart.line_items.build(product: product)
    @line_item = @cart.add_product(product.id)

   #return render plain: @line_item.cart
   #return render plain: @line_item.inspect
   #return render plain: @line_item.build_cart(id: params[:product_id]).inspect

    respond_to do |format|
      if @line_item.save
        #format.html { redirect_to @line_item, notice: 'Line item was successfully created.' }
        #format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
        #format.html { redirect_to @line_item.cart }
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }#чтобы отправить AJAX-запрос
        #Сначала мы не дадим действию create осуществить перенаправление на отображение главной страницы, 
        # если запрос предназначается для JavaScript. 
        # Мы сделаем это путем добавления вызова метода respond_to() format.js, 
        # в котором ему сообщается, что нам нужно получить ответ в формате .js.
        # и вызовет этот файл /app/views/line_items/create.js.erb


        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy   
    #@line_item = @cart.remove_product(params[:id])
    @line_item.quantity -= 1
    #return render plain: @cart.line_items.length
    @line_item.quantity < 1 ? (@line_item.destroy) : (@line_item.save)
    # if @line_item.quantity < 1
    #   @line_item.destroy
    # else
    #   @line_item.save
    # end 
    respond_to do |format|
      #format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      #format.html { redirect_to @line_item.cart, notice: 'Line item was successfully destroyed.' }
      format.html { redirect_to store_url }
      format.js { @current_item = @line_item }#чтобы отправить AJAX-запрос
      #format.js {  @current_item = @line_item, render( :json => ["OK"] ) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      #params.require(:line_item).permit(:product_id, :cart_id)
      params.require(:line_item).permit(:product_id) # удалим cart_id из перечня разрешенных параметров.
      # :line_item - Имя хеша, :product_id, :cart_id - ключи хеша
      # Написано верни хеш по имени :line_item, и значения с ключами :product_id, :cart_id ,остальное не надо
    end
end
