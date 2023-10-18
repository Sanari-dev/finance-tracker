class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.search_user(search)
    search.strip!
    where(email: search).or(where(first_name: search)).or(where(last_name: search))
  end

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_stock(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def friend_already_tracked?(user_id, friend_id)
    Friendship.where(user_id: user_id, friend_id: friend_id).exists?
  end

  def under_friend_limit?
    friends.count < 10
  end

  def can_track_friend?(user_id, friend_id)
    under_friend_limit? && !friend_already_tracked?(user_id, friend_id)
  end
end
