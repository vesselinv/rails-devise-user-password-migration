class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def valid_password?(password)
    if legacy_password?
      # Use Devise's secure_compare to avoid timing attacks
      return false unless Devise.secure_compare(self.encrypted_password,
                                                User.legacy_password(password))
      self.attributes = { password:               password,
                          password_confirmation:  password,
                          legacy_password:        false }
      self.save!
    end
    super password
  end

  # Put your legacy password hashing method here
  def self.legacy_password(password)
    Digest::MD5.hexdigest(password)
  end
end
