class User < ApplicationRecord
  has_many :items
  has_many :orders
  has_many :reviews

  # def self.build_from_github(auth_hash)
  #   user = User.new(provider: auth_hash['provider'], uid: auth_hash['uid'], nickname: auth_hash['info']['nickname'], name: auth_hash['info']['name'], email: auth_hash['info']['email'], image_url: auto_hash['info']['image'])
  # end

  private

  #instance method to find products for this user
  def find_products
    return self.products
  end
end
