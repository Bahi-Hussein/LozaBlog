class Article < ActiveRecord::Base

	has_many :articles_tags
	has_many :tags, through: :articles_tags

	
	belongs_to :user
	has_many :likes
	
	validates :title, presence: true, length:{minimum: 10, maximum: 50}
	validates :body, presence: true, length:{minimum: 25, maximum: 800}

	validates :user_id, presence: true

	def likes_total
		self.likes.where(like: true).size
	end

	def dislikes_total
		self.likes.where(like: false).size
	end


	#for carrierwave
	mount_uploader :image, ImageUploader

	#image validation
	validate :image_size

	private 
		def image_size
			if image.size > 5.megabytes
				error.add(:image, "should be lessthan 5MB")
			end 
		end
end
