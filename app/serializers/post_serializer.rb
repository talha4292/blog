class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :title, :text, :status, :image
  belongs_to :user
  has_many :likes
  has_many :comments
  
  def image
    object.image_url
  end
end