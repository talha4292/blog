# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show view destroy]

  def show
    redirect_to @comment.commentable
  end

  def view; end

  def create
    @comment = current_user.comments.new(comment_params)
    authorize @comment
    flash[:notice] = @comment.errors.full_messages.to_sentence unless @comment.save
    redirect_to @comment.commentable
  end

  def destroy
    commentable = @comment.commentable
    @comment.destroy
    redirect_to commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type, :parent_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end
