class Account < ActiveRecord::Base
	validates :username, presence: true
	validates :balance, presence: true
	validates :password, presence: true
end
