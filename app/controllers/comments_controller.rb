# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  def view
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    flash[:notice] = @comment.errors.full_messages.to_sentence unless @comment.save
    redirect_to @comment.commentable
  end

  def destroy
    @comment = Comment.find(params[:id])
    commentable = @comment.commentable
    @comment.destroy
    redirect_to commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :parent_id)
  end
end
