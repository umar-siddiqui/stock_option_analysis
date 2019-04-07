class ScrappingUrl
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :url, type: String
  field :date, type: Date

  # Associations
  has_many :pboxes
end