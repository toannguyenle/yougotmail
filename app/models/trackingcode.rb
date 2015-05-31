class Trackingcode
  include Mongoid::Document
  field :code, type: String
  field :type, type: String
  field :expiredtime, type: Date
  field :use_once_only, type: Mongoid::Boolean

  belongs_to :user
end
