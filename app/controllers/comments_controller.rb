# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.commentable_id = params[:post_id]
    @comment.commentable_type = 'Post'
    @comment.save
    redirect_to post_path(@comment.commentable)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy
    redirect_to post_path(@commentable)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
