class Trackingcode
  include Mongoid::Document
  field :code, type: String
  field :type, type: String
  field :expiredtime, type: Date
  field :use_once_only, type: Mongoid::Boolean
  field :never_expired, type: Mongoid::Boolean

  validates :code, presence: true

  belongs_to :user
end
