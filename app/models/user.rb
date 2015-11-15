class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true #проверяем наличие и уникальность имени
  has_secure_password #он заставляет Rails проверить совпадение двух паролей. Эта строка была добавлена потому, что при создании временной платформы вы указали password:digest.
end
