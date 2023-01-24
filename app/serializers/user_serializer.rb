class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
    
  attributes :id, :username, :image

  def image
    object.image_url
  end
end