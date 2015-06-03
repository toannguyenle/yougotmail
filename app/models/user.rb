class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  has_secure_password

  field :name,         :type => String
  field :email,         :type => String
  field :password_digest, :type => String
  field :accept_terms, type: Mongoid::Boolean
  
  validates :email, presence: true, email: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }
  validates :accept_terms, acceptance: true
  validates :password_confirmation, presence: true

  has_many :trackingcodes, dependent: :destroy
end