# frozen_string_literal: true

# PostsController
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit approve_status update destroy]

  def index
    @posts = current_user.posts.descending
    authorize @posts
  end

  def approve
    @posts = Post.unapproved.descending
    authorize @posts
  end

  def show; end

  def new
    @post = Post.new
    authorize @post
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def approve_status
    @post.approved!
    redirect_to approve_posts_path
  end

  def update
    if @post.user != current_user
      current_user.suggestions.create(text: post_params[:text], post: @post)
      redirect_to @post
    elsif @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
