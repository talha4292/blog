# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Suggestions', type: :request do
  let(:sign_in_required) { 'You need to sign in or sign up before continuing.' }
  let(:user1) { create(:user, :user) }
  let(:user2) { create(:user, :user) }
  let(:user3) { create(:user, :user) }
  let(:moderator) { create(:user, :moderator) }
  let(:post1) { create(:post, :approved, user_id: user1.id) }
  let(:suggestion_one) { create(:suggestion, post_id: post1.id, user_id: user2.id, updated_at: 1.day.ago) }
  let(:suggestion_two) { create(:suggestion, post_id: post1.id, user_id: user3.id, updated_at: 1.day.ago) }

  def suggestion_params
    { text: '<div><strong>This is content of post</strong></div>', user_id: user2.id, post_id: post1.id }
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
      context 'when show suggestion path is given' do
        it 'renders show action of suggestion' do
          get suggestion_path(suggestion_one.id)
          expect(response).to render_template(:show)
        end
      end

      context 'when unknown suggestion ID is given' do
        it 'gives record not found alert' do
          get suggestion_path('1234-23')
          expect(flash[:alert]).to eq('Record you are trying to find does not exists')
        end
      end
    end

    describe '#new' do
      it 'renders the new template' do
        get new_post_suggestion_path(post1.id)
        expect(response).to render_template(:new)
      end
    end

    describe '#edit' do
      context 'when own suggestion is given' do
        it 'renders the edit template' do
          get edit_suggestion_path(suggestion_one.id)
          expect(response).to render_template(:edit)
        end
      end

      context 'when someone else suggestion is given' do
        it 'gives un-authorized action alert' do
          get edit_suggestion_path(suggestion_two.id)
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end

      context 'when unknown suggestion ID is given' do
        it 'gives record not found alert' do
          get edit_suggestion_path('5989-78')
          expect(flash[:alert]).to eq('Record you are trying to find does not exists')
        end
      end
    end

    describe '#create' do
      it 'creates a suggestion' do
        post post_suggestions_path(post1.id), params: { suggestion: suggestion_params }
        expect(flash[:notice]).to eq('Suggestion has been created')
      end
    end

    describe '#update' do
      context 'when own suggestion is given' do
        it 'updates a suggestion' do
          patch suggestion_path(suggestion_one.id), params: { suggestion: { text: 'text updated' } }
          expect(flash[:notice]).to eq('Suggestion has been updated')
        end
      end

      context 'when unknown suggestion ID is given' do
        it 'gives record not found alert' do
          patch suggestion_path('5989-78'), params: { suggestion: { text: 'text updated' } }
          expect(flash[:alert]).to eq 'Record you are trying to find does not exists'
        end
      end

      context 'when someone else suggestion is given' do
        it 'gives un-authorized action alert' do
          patch suggestion_path(suggestion_two.id), params: { suggestion: { text: 'text updated' } }
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end
    end

    describe '#destroy' do
      context 'when own suggestion is given' do
        it 'deletes a suggestion' do
          delete suggestion_path(suggestion_one.id)
          expect(flash[:notice]).to eq('Suggestion has been deleted')
        end
      end

      context 'when unknown suggestion ID is given' do
        it 'gives record not found alert' do
          delete suggestion_path('5989-78')
          expect(flash[:alert]).to eq('Record you are trying to find does not exists')
        end
      end

      context 'when someone else suggestion is given' do
        it 'gives un-authorized action alert' do
          delete suggestion_path(suggestion_two)
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end
    end
  end
end
