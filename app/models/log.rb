class Log
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fromdevice, type: String
  field :params, type: String
  field :response, type: String

  belongs_to :user
end
