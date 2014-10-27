require 'bcrypt'
class User < ActiveRecord::Base
  validates :username, uniqueness: true
  include BCrypt

  def password
    Password.new(self.hashed_password)
  end

  def password=(new_password)
      self.hashed_password = Password.create(new_password)
  end
end