# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  before_action :set_like_policy, only: %i[create]

  def create
    @like = current_user.likes.new(like_params)
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save

    post = @like.likeable
    post = post.commentable until post.instance_of?(Post) || post.instance_of?(Suggestion)

    req_format(post)
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    post = @like.likeable
    post = post.commentable until post.instance_of?(Post) || post.instance_of?(Suggestion)
    @like.destroy
    req_format(post)
  end

  private

  def set_like_policy
    authorize Like
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

  def req_format(post)
    respond_to do |format|
      format.js
      format.html { redirect_to post }
    end
  end
end
