# frozen_string_literal: true

# SuggestionsController
class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: %i[show edit update destroy]

  def list
    @suggestions = current_user.suggestions.descending
    authorize @suggestions
  end

  def show; end

  def edit; end

  def update
    if @suggestion.user != current_user
      @suggestion.post.update(suggestion_params)
      redirect_to @suggestion.post
    elsif @suggestion.update(suggestion_params)
      redirect_to list_suggestion_path(@suggestion)
    else
      render 'edit'
    end
  end

  def destroy
    @suggestion.destroy
    redirect_to list_suggestion_path(current_user)
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
    authorize @suggestion
  end

  def suggestion_params
    params.require(:suggestion).permit(:text)
  end
end
