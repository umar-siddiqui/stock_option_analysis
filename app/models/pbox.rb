class Pbox
  include Mongoid::Document
  include Mongoid::Timestamps
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

  # callbacks
  before_save :calculate_pbox

  def calculate_pbox
    self.pbox_value = (sco - sci) - ((ltp_sco + ltp_spo) - (ltp_sci + ltp_spi))
    self.pbox_value = self.pbox_value.round(2)
  end
end
