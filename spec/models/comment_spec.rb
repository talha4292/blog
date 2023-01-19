# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user, :user) }
  let(:post) { create(:post, :approved, user_id: user.id) }
  let(:comment_one) { create(:comment, commentable: post, user_id: user.id, updated_at: 1.day.ago) }
  let(:comment_two) { create(:comment, commentable: post, user_id: user.id, updated_at: 1.hour.ago) }

  describe 'associations tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to belong_to(:parent).class_name('Comment').optional(true) }
    it { is_expected.to have_many(:replies).with_foreign_key(:parent_id).dependent(:destroy).inverse_of(:parent) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'scope tests' do
    it 'return comments order by updated_at timestamp descendingly (recent to oldest)' do
      expect(described_class.descending).to eq [comment_two, comment_one]
    end
  end

  describe 'validations tests' do
    it { is_expected.to validate_presence_of(:text) }
  end
end
