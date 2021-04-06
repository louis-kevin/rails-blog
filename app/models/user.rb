class User < ApplicationRecord
  has_many :posts

  validates :username, presence: true, length: {minimum: 6}
  validates :email, presence: true, uniqueness: true, format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/}
  validates :password, presence: true, length: {minimum: 8}
end
