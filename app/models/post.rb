class Post < ApplicationRecord

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	# has_attached_file :image

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


	# returns true if a user can like this post
	def user_can_like(user_id)
		if self.likes.where(user_id: user_id).length > 0
			return false
		end

		return true

	end


	def like_status_string(user_id)
		if self.user_can_like(user_id)
			return 'Like'
		else
			return 'Unlike'

		end

	end

end
