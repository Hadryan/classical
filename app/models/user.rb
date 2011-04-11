# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  app_language_id      :integer
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class User < ActiveRecord::Base
  include Gravtastic

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_authorization_subject  :association_name => :roles

  gravtastic

	belongs_to :app_language

  has_many :user_albums, :dependent => :destroy
  has_many :albums, :through => :user_albums

  has_many :authentications, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  def self.new_from_facebook(data)
    #Examle response
    # {"id"=>
    #  "name"=>
    #  "first_name"=>
    #  "middle_name"=>
    #  "last_name"=>
    #  "link"=>
    #  "username"=>
    #  "hometown"=>{"id"=>, "name"=>},
    #  "gender"=>
    #  "email"=>
    #  "timezone"=>
    #  "locale"=>"en_US",
    #  "verified"=>
    #  "updated_time"=>}

    user = self.new
    user.email = data["extra"]["user_hash"]["email"]
    user
  end
end

