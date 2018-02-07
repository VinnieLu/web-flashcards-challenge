class User < ApplicationRecord
  has_many :rounds
  has_many :decks, through: :rounds
  has_many :cards, through: :decks

  validates :username, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(username)
    # if email corresponds to a valid user, return that user
   	User.find_by(username: username)
  end


end
