class User < ApplicationRecord
    before_validation :ensure_session_token
    # has_secure_password
    validates :username, uniqueness: true, length: { in:3..30}
    validates :password, length: { in:3..30}
    validates :session_token, presence: true, uniqueness: true

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user[:password] == password
          @user
        else
            nil
        end
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    private

    def generate_unique_session_token
        valid_session_token = false
  
        while valid_session_token == false
          self.session_token = SecureRandom.urlsafe_base64
          if User.exists?(self.session_token)
            valid_session_token = true
          end
        end
        self.session_token
    end
  
    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
end
