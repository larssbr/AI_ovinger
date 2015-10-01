class User < ActiveRecord::Base
  has_many :reading_lists, :dependent => :destroy
  has_many :owned_groups, :class_name => 'Group', :foreign_key => 'owner_id', :dependent => :destroy
  has_many :group_members, :dependent => :destroy
  has_many :groups, :through => :group_members
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid, :name, :first_name, :last_name, :description, :picture,
                  :added_to_group, :list_shared,:comment_added, :paper_added

  validates_presence_of :name
                  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    user = User.create(name: data["name"],
  		                email: data["email"],
  		                password: Devise.friendly_token[0,20]
  		                ) unless user

    user
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def name=(input_name)
    words = input_name.split(" ")
    self.first_name = words[0]
    self.last_name = words.try :[], 1
  end
  
end