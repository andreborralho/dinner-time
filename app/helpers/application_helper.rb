module ApplicationHelper

	def decode_image_url(url)
		CGI.unescape(url)
	end
end
