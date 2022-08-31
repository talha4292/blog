# frozen_string_literal: true

# CommentsHelper
module CommentsHelper
  def comment_like_button(comment)
    like = current_user.likes.find_by(likeable: comment)
    if like.nil?
      render partial: 'likes/like', locals: { object: comment, type: 'Comment' }
    else
      render partial: 'likes/unlike', locals: { like: like }
    end
  end
end
