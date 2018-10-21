class User < ApplicationRecord
  has_many :items
  has_many :orders
  has_many :reviews

  # def self.build_from_github(auth_hash)
  #   user = User.new(provider: auth_hash['provider'], uid: auth_hash['uid'], nickname: auth_hash['info']['nickname'], name: auth_hash['info']['name'], email: auth_hash['info']['email'], image_url: auto_hash['info']['image'])
  # end

  def is_a_merchant?(given_ids)
    return given_ids.include?(self.id)
  end
end
