# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  include FetchPostFromAssociated

  before_action :set_comment_policy, only: %i[show create]
  before_action :set_comment, only: %i[show destroy]

  def show; end

  def create
    @comment = current_user.comments.new(comment_params)
    flash[:notice] = @comment.errors.full_messages.to_sentence unless @comment.save
    post = fetch_post(@comment.commentable)
    req_format(post)
  end

  def destroy
    authorize @comment
    post = fetch_post(@comment.commentable)
    @comment.destroy
    req_format(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :image, :commentable_id, :commentable_type, :parent_id)
  end

  def set_comment_policy
    authorize Comment
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def req_format(post)
    respond_to do |format|
      format.js
      format.html { redirect_to post }
    end
  end
end
