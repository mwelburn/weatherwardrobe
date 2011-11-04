class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facebook_id, :name, :email, :gender, :password, :password_confirmation, :remember_me

  validates :gender, :inclusion => { :in => %w(M F) }
  validates_uniqueness_of :facebook_id

  # Remove this if we ever allow non-Facebook access
  validates_presence_of :facebook_id

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_facebook_id(data["id"])
      # TODO - should we check if we need to update any information here?
      user
    else # Create a user with a stub password.
      # TODO - What do we do if this is empty...
      gender = 'M' # I guess default is Male
      if !data["gender"].nil?
        gender = data["gender"][0].upcase
      end
      User.create(:facebook_id => data["id"], :email => data["email"], :name => data["name"], :gender => gender, :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.facebook_id = data["facebook_id"]
        user.email = data["email"]
        user.name = data["name"]
        user.gender = data["gender"]
      end
    end
  end
end
