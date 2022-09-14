# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  include FetchPostFromAssociated

  before_action :set_like_policy, only: %i[create]

  def create
    @like = current_user.likes.new(like_params)
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
    post = fetch_post(@like.likeable)
    req_format(post)
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    post = fetch_post(@like.likeable)
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
