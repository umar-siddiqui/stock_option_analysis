class ScrappingUrl
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :date, type: Date
end
