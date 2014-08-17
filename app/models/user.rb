class User < ActiveRecord::Base
  has_secure_password
  validates :account, presence: true, uniqueness: true
  validates_presence_of :password_confirmation, :on => :create
end
