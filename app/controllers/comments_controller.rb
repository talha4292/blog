# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  before_action :set_comment_policy, only: %i[show create]
  before_action :set_comment, only: %i[show destroy]

  def show; end

  def create
    @comment = current_user.comments.new(comment_params)
    flash[:notice] = @comment.errors.full_messages.to_sentence unless @comment.save
    post = @comment.commentable
    post = post.commentable until post.instance_of?(Post) || post.instance_of?(Suggestion)
    redirect_to post
  end

  def destroy
    authorize @comment
    post = @comment.commentable
    post = post.commentable until post.instance_of?(Post) || post.instance_of?(Suggestion)
    @comment.destroy
    redirect_to post
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
end
