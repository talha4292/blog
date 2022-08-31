# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
    redirect_to @like.likeable
  end

  def destroy
    @like = Like.find(params[:id])
    likeable = @like.likeable
    @like.destroy
    redirect_to likeable
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
