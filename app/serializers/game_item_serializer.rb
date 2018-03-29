class GameItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :eatable, :image_path
end
