class SuggestionsController < ApplicationController
  def list
    @suggestions = current_user.suggestions.descending
  end

  def show
    @suggestion = Suggestion.find(params[:id])
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def update
    @suggestion = Suggestion.find(params[:id])

    if @suggestion.user != current_user
      @suggestion.post.update(suggestion_params)
      redirect_to  @suggestion.post
    elsif @suggestion.update(suggestion_params)
      redirect_to list_suggestion_path(@suggestion)
    else
      render 'edit'
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    redirect_to list_suggestion_path(current_user)
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:content)
  end
end
