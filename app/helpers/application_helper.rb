module ApplicationHelper

	def user_avatar(user, size=40)
		if user.profile_image.attached?
			user.profile_image.variant(resize: "#{size}x#{size}!")
		else
			gravatar_image_url(user.email, size: size)
		end
	end
	
end
