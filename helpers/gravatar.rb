require 'digest/md5'

def gravatar_img_src_for_email(email)
  # get the email from URL-parameters or what have you and make lowercase
  email_address = email.downcase
  # create the md5 hash
  hash = Digest::MD5.hexdigest(email_address)
  # compile URL which can be used in <img src="RIGHT_HERE"...
  "http://www.gravatar.com/avatar/#{hash}"
end
