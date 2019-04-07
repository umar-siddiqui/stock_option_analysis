class Pbox
  include Mongoid::Document
  field :sci, type: Float
  field :ltp_sci, type: Float
  field :sco, type: Float
  field :ltp_sco, type: Float
  field :spi, type: Float
  field :ltp_spi, type: Float
  field :spo, type: Float
  field :ltp_spo, type: Float
  field :pbox_value, type: Float

  # Associations
  belongs_to :scrapping_url
end
