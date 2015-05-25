class Trackingcode
  include Mongoid::Document
  field :code, type: String
  field :type, type: String

  belongs_to :user
end
