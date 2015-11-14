require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products #вместо загрузки всех стендовых данных, загрузим только одну группу

  test "buying a product" do
    LineItem.delete_all #очистим эти таблицы от данных.
    Order.delete_all #очистим эти таблицы от данных.
    ruby_book = products(:ruby) #загрузим эти данные в локальную переменную:

   #Пользователь заходит на страницу каталога магазина
    get "/"
    assert_response :success # ответ
    assert_template "index" # шаблон

   #Он выбирает товар, добавляя его в свою корзину»
    xml_http_request :post, '/line_items', product_id: ruby_book.id #использует Ajax -запросы, поэтому для вызова действия мы будем использовать метод xml_http_request().
    assert_response :success
   #Когда метод вернет управление, мы проверим факт наличия в корзине запрошенного товара:
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size # равным
    assert_equal ruby_book, cart.line_items[0].product 

   #Затем он оформляет заказ...
    get "/orders/new"
    assert_response :success
    assert_template "new"
    
    post_via_redirect "/orders",
        order: { name: "Dave Thomas",
                address: "123 The Street",
                email: "dave@example.com",
                pay_type: "Check" } #пользователь заполнил форму заказа своими данными
    assert_response :success
    assert_template "index"
   #Затем мы заглянем в базу данных и убедимся, что мы создали заказ и соответствующую товарную позицию и что в них содержатся верные сведения. Поскольку перед началом тестирования мы очистили таблицу orders, мы просто проверим, что теперь в ней содержится только лишь наш новый заказ:
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
    
   #мы проверим, что само почтовое отправление правильно адресовано и имеет ожидаемую нами строку темы:
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject   
  end
end
