class LikeSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers
    
    attributes :id
end