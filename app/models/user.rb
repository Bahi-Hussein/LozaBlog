class User < ActiveRecord::Base
	
	has_many :articles, dependent: :destroy
	belongs_to :role

	validates :name, presence: true, length:{minimum: 3, maximum: 25}
	validates :desc, length:{minimum: 15, maximum: 100 }

	VALID_EMAIL_REGEX = /\A[\w+\1-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	before_save {self.email = email.downcase}
	validates :email, presence: true, uniqueness: {case_sensitive: false}, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
	
	has_secure_password
end
