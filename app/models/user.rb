class User
  include Mongoid::Document
  field :password, type: String
  field :email, type: String

  has_many :trackingcodes
end
