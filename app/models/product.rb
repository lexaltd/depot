class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true # проверки наличия какого-нибудь содержимого во всех текстовых полях перед записью строки в базу данных
  validates :price, numericality: {greater_than_or_equal_to: 0.01} # (больше чем или равно) значение 0.01:
  validates :title, uniqueness: true # уникальное название.
  validates :image_url, allow_blank: true, format: {# во избежание получения нескольких сообщений об ошибках при пустом поле используется параметр allow_blank.
            with: %r{\.(gif|jpg|png)\Z}i,
            message: 'URL должен указывать на изображение формата GIF, JPG или PNG.'
          } # проверим, что URL-адрес заканчивается одним из расширений: .gif, .jpg или .png.
  validates :title, length: {minimum: 10}
  
  def self.latest
    Product.order(:updated_at).last # возвращающий товар, который подвергся изменениям последним.
  end        
end
