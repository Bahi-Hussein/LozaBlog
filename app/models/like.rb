class Like < ActiveRecord::Base
	belongs_to :article
	belongs_to :user

	validates :user_id, presence: true
	validates :article_id, presence: true

	validates_uniqueness_of :user, scope: :article
end
