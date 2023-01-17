# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:sign_in_required) { 'You need to sign in or sign up before continuing.' }
  let(:user) { create(:user, :user) }
  let(:moderator) { create(:user, :moderator) }
  let(:post_one) { create(:post, :approved, user_id: user.id, updated_at: 1.day.ago) }
  let(:post_two) { create(:post, :approved, user_id: moderator.id, updated_at: 1.hour.ago) }

  def post_params_with_image
    { title: 'title', text: '<div><strong>This is content of post</strong></div>', status: 'approved', user_id: user.id,
      image: fixture_file_upload(Rails.root.join('spec/fixtures/p1.jpeg')) }
  end

  def post_params_without_image
    { title: 'title', text: '<div><strong>This is content of post</strong></div>', status: 'approved',
      user_id: user.id }
  end

  describe 'when user is not signed in' do
    describe '#index' do
      it 'redirects to signin page' do
        get posts_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#approve' do
      it 'redirects to signin page' do
        get approve_posts_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#show' do
      it 'redirects to sigin page' do
        get post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#new' do
      it 'redirects to sigin page' do
        get new_post_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#edit' do
      it 'redirects to sigin page' do
        get edit_post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#create' do
      it 'redirects to sigin page' do
        post posts_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#update' do
      it 'redirects to sigin page' do
        patch post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#destroy' do
      it 'redirects to sigin page' do
        delete post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end
  end

  describe 'when user is signed in' do
    before do
      sign_in user
    end

    describe '#index' do
      context 'when posts_path is requested' do
        it 'renders index action of post' do
          get posts_path
          expect(response).to render_template(:index)
        end
      end
    end

    describe '#approve' do
      context 'when approve_posts_path is requested' do
        it 'gives un-authorized action alert' do
          get approve_posts_path
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end
    end

    describe '#show' do
      context 'when show post path is given' do
        it 'renders show action of post' do
          get post_path(post_one.id)
          expect(response).to render_template(:show)
        end
      end
    end

    describe '#new' do
      context 'when new post path is requested' do
        it 'renders the new template' do
          get new_post_path
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#edit' do
      context 'when own post is given' do
        it 'renders the edit template' do
          get edit_post_path(post_one.id)
          expect(response).to render_template(:edit)
        end
      end

      context 'when someone else post is given' do
        it 'gives un-authorized action alert' do
          get edit_post_path(post_two.id)
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end

      context 'when unknown post ID is given' do
        it 'gives record not found alert' do
          get edit_post_path('5989-78')
          expect(flash[:alert]).to eq('Record you are trying to find does not exists')
        end
      end
    end

    describe '#create' do
      context 'when cover image is given' do
        it 'creates a post' do
          post posts_path, params: { post: post_params_with_image }
          expect(flash[:notice]).to eq('Post has been created')
        end
      end

      context 'when cover image is not given' do
        it 're-renders new template and post not created' do
          post posts_path, params: { post: post_params_without_image }
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#update' do
      context 'when own post is given' do
        it 'updates a post' do
          patch post_path(post_one.id), params: { post: { text: 'text updated' } }
          expect(flash[:notice]).to eq 'Post has been updated'
        end
      end

      context 'when unknown post ID is given' do
        it 'gives record not found alert' do
          patch post_path('5989-78'), params: { post: { text: 'text updated' } }
          expect(flash[:alert]).to eq 'Record you are trying to find does not exists'
        end
      end

      context 'when someone else post is given' do
        it 'gives un-authorized action alert' do
          patch post_path(post_two), params: { post: { text: 'text updated' } }
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end
    end

    describe '#destroy' do
      context 'when own post is given' do
        it 'deletes a post' do
          delete post_path(post_one)
          expect(flash[:notice]).to eq('Post has been deleted')
        end
      end

      context 'when unknown post ID is given' do
        it 'gives record not found alert' do
          delete post_path('5989-78')
          expect(flash[:alert]).to eq('Record you are trying to find does not exists')
        end
      end

      context 'when someone else post is given' do
        it 'gives un-authorized action alert' do
          delete post_path(post_two)
          expect(flash[:alert]).to eq('You are not authorized for this action')
        end
      end
    end
  end

  describe 'when moderator is signed in' do
    before do
      sign_in moderator
    end

    describe '#approve' do
      context 'when approve_posts_path is requested' do
        it 'renders approve action of post' do
          get approve_posts_path
          expect(response).to render_template(:approve)
        end
      end
    end
  end
end
