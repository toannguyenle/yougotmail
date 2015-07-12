class Phone
  include Mongoid::Document
  field :number, type: String
  field :type, type: String
  field :allow_notifications, type: Mongoid::Boolean

  validates :number, presence: true

  belongs_to :user

end
