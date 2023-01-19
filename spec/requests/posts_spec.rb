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

  def invalid_post_params
    { title: '', text: '<div><strong>This is content of post</strong></div>', status: 'approved', user_id: user.id,
      image: fixture_file_upload(Rails.root.join('spec/fixtures/p1.jpeg')) }
  end

  context 'when user is not signed in' do
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
      it 'redirects to signin page' do
        get post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#new' do
      it 'redirects to signin page' do
        get new_post_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#edit' do
      it 'redirects to signin page' do
        get edit_post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#create' do
      it 'redirects to signin page' do
        post posts_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#update' do
      it 'redirects to signin page' do
        patch post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#destroy' do
      it 'redirects to signin page' do
        delete post_path(post_one.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end
  end

  context 'when user is signed in' do
    before do
      sign_in user
    end

    describe '#index' do
      it 'renders index action of post' do
        get posts_path
        expect(response).to render_template(:index)
      end
    end

    describe '#approve' do
      it 'gives un-authorized action alert' do
        get approve_posts_path
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end
    end

    describe '#show' do
      it 'renders show action of post when show post path is given' do
        get post_path(post_one.id)
        expect(response).to render_template(:show)
      end

      it 'gives record not found alert when unknown post ID is given' do
        get post_path('5989-78')
        expect(flash[:alert]).to eq('Record you are trying to find does not exists')
      end
    end

    describe '#new' do
      it 'renders the new template' do
        get new_post_path
        expect(response).to render_template(:new)
      end
    end

    describe '#edit' do
      it 'renders the edit template when own post is given' do
        get edit_post_path(post_one.id)
        expect(response).to render_template(:edit)
      end

      it 'gives un-authorized action alert when someone else post is given' do
        get edit_post_path(post_two.id)
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end

      it 'gives record not found alert when unknown post ID is given' do
        get edit_post_path('5989-78')
        expect(flash[:alert]).to eq('Record you are trying to find does not exists')
      end
    end

    describe '#create' do
      it 'creates a post when cover image is given' do
        post posts_path, params: { post: post_params_with_image }
        expect(flash[:notice]).to eq('Post has been created')
      end

      it 're-renders new template and post not created when cover image is not given' do
        post posts_path, params: { post: post_params_without_image }
        expect(response).to render_template(:new)
      end
    end

    describe '#update' do
      it 'updates a post when own post is given' do
        patch post_path(post_one.id), params: { post: { text: 'text updated' } }
        expect(flash[:notice]).to eq 'Post has been updated'
      end

      it 'gives text can\'t be blank error when text is nil' do
        patch post_path(post_one.id), params: { post: { text: nil } }
        expect(flash[:notice]).to include 'Text can\'t be blank'
      end

      it 'gives record not found alert when unknown post ID is given' do
        patch post_path('5989-78'), params: { post: { text: 'text updated' } }
        expect(flash[:alert]).to eq 'Record you are trying to find does not exists'
      end

      it 'gives un-authorized action alert when someone else post is given' do
        patch post_path(post_two), params: { post: { text: 'text updated' } }
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end
    end

    describe '#destroy' do
      it 'deletes a post when own post is given' do
        delete post_path(post_one)
        expect(flash[:notice]).to eq('Post has been deleted')
      end

      it 'gives record not found alert when unknown post ID is given' do
        delete post_path('5989-78')
        expect(flash[:alert]).to eq('Record you are trying to find does not exists')
      end

      it 'gives un-authorized action alert when someone else post is given' do
        delete post_path(post_two)
        expect(flash[:alert]).to eq('You are not authorized for this action')
      end
    end
  end

  context 'when moderator is signed in' do
    before do
      sign_in moderator
    end

    describe '#approve' do
      it 'renders approve action of post' do
        get approve_posts_path
        expect(response).to render_template(:approve)
      end
    end
  end
end
