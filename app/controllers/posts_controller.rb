# frozen_string_literal: true

# PostsController
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_post_policy, only: %i[index approve new create]

  def index
    @posts = current_user.posts.descending
  end

  def approve
    @posts = Post.unapproved.descending
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit
    suggestion_text = retrive_suggestion_text
    @post.text = suggestion_text if suggestion_text
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = t('post.post_created')
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      @post.reports.destroy_all
      flash[:notice] = t('post.post_updated')
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = t('post.post_deleted')
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def set_post_policy
    authorize Post
  end

  def post_params
    params.require(:post).permit(:title, :image, :text, :status)
  end

  def retrive_suggestion_text
    suggestion_id = params.permit(:suggestion_id).values[0]
    Suggestion.where(id: suggestion_id).pluck(:text)[0]
  end
end
