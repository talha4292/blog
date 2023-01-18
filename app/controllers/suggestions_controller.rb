# frozen_string_literal: true

# SuggestionsController
class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: %i[show edit update destroy]
  before_action :set_suggestion_policy, only: %i[index new]

  def index
    @suggestions = current_user.suggestions.descending
  end

  def show; end

  def new
    @suggestion = Suggestion.new
    @post = find_post
  end

  def edit; end

  def create
    @suggestion = current_user.suggestions.new(suggestion_params)
    authorize @suggestion
    flash[:notice] = @suggestion.errors.full_messages unless @suggestion.save
    flash[:notice] = t('suggestion.suggestion_created')
    redirect_to post_path(@suggestion.post)
  end

  def update
    if @suggestion.update(suggestion_params)
      flash[:notice] = t('suggestion.suggestion_updated')
      redirect_to suggestion_path(@suggestion)
    else
      render 'edit'
    end
  end

  def destroy
    @suggestion.destroy
    flash[:notice] = t('suggestion.suggestion_deleted')
    redirect_to suggestions_path
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
    authorize @suggestion
  end

  def set_suggestion_policy
    authorize Suggestion
  end

  def suggestion_params
    params.require(:suggestion).permit(:text, :post_id)
  end

  def find_post
    Post.find(params[:post_id])
  end
end
