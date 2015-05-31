class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  has_secure_password

  field :name,         :type => String
  field :email,         :type => String
  field :password_digest, :type => String
  field :accept_terms, type: Mongoid::Boolean
  
  validates_presence_of :email, :message => "Email Address is Required."
  # validates_uniqueness_of :email, :message => "Email Address Already In Use. Have You Forgot Your Password?"
  # validates_format_of :email, :multiline => true, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "Please Enter a Valid Email Address."
  # validates_acceptance_of :accept_terms, :allow_nil => false, :accept => true, :message => "Terms and Conditions Must Be Accepted."
  # validates_length_of :password, :minimum => 6, :message => "Password Must Be Longer Than 6 Characters."
  # validates_confirmation_of :password, :message => "Password Confirmation Must Match Given Password."

  has_many :trackingcodes, dependent: :destroy
end