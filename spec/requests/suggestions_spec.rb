# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Suggestions', type: :request do
  let(:sign_in_required) { 'You need to sign in or sign up before continuing.' }
  let(:user1) { create(:user, :user) }
  let(:user2) { create(:user, :user) }
  let(:user3) { create(:user, :user) }
  let(:moderator) { create(:user, :moderator) }

  def post1
    create(:post, :approved, user_id: user1.id)
  end

  def suggestion_one
    create(:suggestion, post_id: post1.id, user_id: user2.id, updated_at: 1.day.ago)
  end

  def suggestion_two
    create(:suggestion, post_id: post1.id, user_id: user3.id, updated_at: 1.day.ago)
  end

  def suggestion_params
    { text: '<div><strong>This is content of post</strong></div>', user_id: user2.id, post_id: post1.id }
  end

  def nil_text_suggestion_params
    { text: nil, user_id: user2.id, post_id: post1.id }
  end

  describe 'when user is not signed in' do
    describe '#index' do
      it 'redirects to signin page' do
        get suggestions_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#show' do
      it 'redirects to signin page' do
        get suggestion_path(suggestion_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#new' do
      it 'redirects to signin page' do
        get new_post_suggestion_path(post1.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#edit' do
      it 'redirects to signin page' do
        get edit_suggestion_path(suggestion_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#create' do
      it 'redirects to signin page' do
        post post_suggestions_path(post1.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#update' do
      it 'redirects to signin page' do
        patch suggestion_path(suggestion_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#destroy' do
      it 'redirects to signin page' do
        delete suggestion_path(suggestion_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end
  end

  describe 'when user is signed in' do
    before do
      sign_in user2
    end

    describe '#index' do
      it 'renders index action of suggestion' do
        get suggestions_path
        expect(response).to render_template(:index)
      end
    end

    describe '#show' do
      it 'renders show action of suggestion when show suggestion path is given' do
        get suggestion_path(suggestion_one.id)
        expect(response).to render_template(:show)
      end

      it 'gives record not found alert when unknown suggestion ID is given' do
        get suggestion_path('1234-23')
        expect(flash[:alert]).to eq('Record you are trying to find does not exists')
      end
    end

    describe '#new' do
      it 'renders the new template' do
        get new_post_suggestion_path(post1.id)
        expect(response).to render_template(:new)
      end
    end

    describe '#edit' do
      it 'renders the edit template when own suggestion is given' do
        get edit_suggestion_path(suggestion_one.id)
        expect(response).to render_template(:edit)
      end

      it 'gives un-authorized action alert when someone else suggestion is given' do
        get edit_suggestion_path(suggestion_two.id)
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end

      it 'gives record not found alert when unknown suggestion ID is given' do
        get edit_suggestion_path('5989-78')
        expect(flash[:alert]).to eq('Record you are trying to find does not exists')
      end
    end

    describe '#create' do
      it 'creates a suggestion when text is given' do
        post post_suggestions_path(post1.id), params: { suggestion: suggestion_params }
        expect(flash[:notice]).to eq('Suggestion has been created')
      end

      it 'gives text can\'t be blank error when text is nil' do
        post post_suggestions_path(post1.id), params: { suggestion: nil_text_suggestion_params }
        expect(flash[:notice]).to include('Text can\'t be blank')
      end
    end

    describe '#update' do
      it 'updates a suggestion when own suggestion is given' do
        patch suggestion_path(suggestion_one.id), params: { suggestion: { text: 'text updated' } }
        expect(flash[:notice]).to eq('Suggestion has been updated')
      end

      it 'gives text can\'t be blank error when text is nil' do
        patch suggestion_path(suggestion_one.id), params: { suggestion: { text: nil } }
        expect(flash[:notice]).to include('Text can\'t be blank')
      end

      it 'gives record not found alert when unknown suggestion ID is given' do
        patch suggestion_path('5989-78'), params: { suggestion: { text: 'text updated' } }
        expect(flash[:alert]).to eq 'Record you are trying to find does not exists'
      end

      it 'gives un-authorized action alert when someone else suggestion is given' do
        patch suggestion_path(suggestion_two.id), params: { suggestion: { text: 'text updated' } }
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end
    end

    describe '#destroy' do
      it 'deletes a suggestion when own suggestion is given' do
        delete suggestion_path(suggestion_one.id)
        expect(flash[:notice]).to eq('Suggestion has been deleted')
      end

      it 'gives record not found alert when unknown suggestion ID is given' do
        delete suggestion_path('5989-78')
        expect(flash[:alert]).to eq('Record you are trying to find does not exists')
      end

      it 'gives un-authorized action alert when someone else suggestion is given' do
        delete suggestion_path(suggestion_two)
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end
    end
  end
end
