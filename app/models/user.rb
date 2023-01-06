class User < ApplicationRecord
    has_secure_password #enables password encryption with BCrypt
    validates :username, presence: true, uniqueness: true 
    has_many :recipes
end
