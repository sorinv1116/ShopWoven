class Shop < ActiveRecord::Base
  include ShopifyApp::Shop

  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/, message: 'is not valid' }
  validates :password, presence: true
  validates :shop, presence: true
end
