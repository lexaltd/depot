class SessionsController < ApplicationController
  skip_before_action :authorize #Вы можете не допустить запуск этого фильтра (authorize) перед определенными экшнами с помощью skip_before_action

  def new
  end

  def create
    if User.count.zero? #Если нет не одного администратора     
      session[:user_id] = 0
      flash[:notice] = "Пожалуйста, создайте пользователя Admin"
      redirect_to new_user_url  
    else
      user = User.find_by(name: params[:name])
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_url
      else
        redirect_to login_url, alert: "Неверная комбинация имени и пароля"
      end
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Сеанс работы завершен"
  end
end
