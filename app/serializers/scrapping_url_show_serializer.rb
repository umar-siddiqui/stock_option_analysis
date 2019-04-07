# class ScrappingUrlSerializer
class ScrappingUrlShowSerializer < ActiveModel::Serializer
  attributes :name, :url
  has_many :pboxes

  def pboxes
    object.pboxes.as_json
  end
end
