class Trackingcode
  include Mongoid::Document
  field :code, type: String
  field :type, type: String
  field :valid_date, type: DateTime
  field :valid_from, type: DateTime
  field :valid_to, type: DateTime
  field :use_once_only, type: Mongoid::Boolean
  field :never_expired, type: Mongoid::Boolean
  field :is_active, type: Mongoid::Boolean

  validates :code, presence: true

  belongs_to :user
end
