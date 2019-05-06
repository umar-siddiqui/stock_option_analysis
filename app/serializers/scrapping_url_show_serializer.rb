# class ScrappingUrlSerializer
class ScrappingUrlShowSerializer < ActiveModel::Serializer
  attributes :name, :url, :_id
  has_many :pboxes

  def pboxes
    object.pboxes.as_json
  end
end
