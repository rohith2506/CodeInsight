class User < ActiveRecord::Base
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates( :username, presence: true , length: {maximum:50 },
					uniqueness: {case_sensitive:false} )
	validate :username_cannot_have_whitespaces
	validates( :name, presence:true , length: {maximum:100} )
	validates(:password, presence:true, length: {minimum:6} )
	validates(:email, presence:true,
				format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive:false})

	has_secure_password

	before_save do
					self.username=username.downcase
					self.email=email.downcase 
				end

	before_create :create_remember_token
	def username_cannot_have_whitespaces
		if(self.username==nil)
			return
		end

		if(self.username.to_s.gsub(/\s+/, "").length==0)
			return #since this has been checked in presence validation..
		end
		#s = "I have white space".delete(' ')
		if(self.username.to_s.gsub(/\s+/, "").length != self.username.to_s.length )
			errors.add(:username,"Cannot have whitespaces")
		end  
	end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token=User.hash(User.new_remember_token)
		end
	
end
