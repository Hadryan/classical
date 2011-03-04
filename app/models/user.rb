# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  app_language_id      :integer
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
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

  has_many :user_albums
  has_many :albums, :through => :user_albums

  has_many :composers
  has_many :directors
  has_many :instruments
  has_many :obra_types
  has_many :orchestras
  has_many :solists

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end

