class ApplicationController < ActionController::Base
  before_action :authorize # заставляет вызывать метод authorize() перед каждым действием в нашем приложении
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def authorize
      unless User.find_by(id: session[:user_id]) # unless этот оператор является своеобразным антонимом if
        redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
      end
    end

    # def authorize
    #   return if User.count.zero?

    #   if request.format == Mime::HTML
    #     user = User.find_by(id: session[:user_id])
    #   else
    #     user = authenticate_or_request_with_http_basic do |u, p|
    #       User.find_by_name(u).try(:authenticate, p)
    #     end
    #   end

    #   redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию" unless user
    # end

end
