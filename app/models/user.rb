class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :gender, :password, :password_confirmation, :remember_me

  validates :gender, :inclusion => { :in => %w(M F) }

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      # TODO - What do we do if this is empty...
      gender = 'M' # I guess default is Male
      if !data["gender"].nil?
        gender = data["gender"][0].upcase
      end
      User.create(:email => data["email"], :name => data["name"], :gender => gender, :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
        user.name = data["name"]
        user.gender = data["gender"]
      end
    end
  end
end
