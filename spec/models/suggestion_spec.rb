# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  def user1
    create(:user, :user)
  end

  def user3
    create(:user, :user)
  end

  let(:user2) { create(:user, :user) }
  let(:post) { create(:post, :approved, user_id: user1.id) }
  let!(:suggestion_one) { create(:suggestion, post_id: post.id, user_id: user2.id, updated_at: 1.day.ago) }
  let!(:suggestion_two) { create(:suggestion, post_id: post.id, user_id: user3.id, updated_at: 1.hour.ago) }
  let(:suggestion_three) { build(:suggestion, post_id: post.id, user_id: user2.id) }

  describe 'associations tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'scope tests' do
    it 'return suggestions order by updated_at timestamp descendingly (recent to oldest)' do
      expect(described_class.descending).to eq [suggestion_two, suggestion_one]
    end
  end

  describe 'validations tests' do
    it { is_expected.to validate_presence_of(:text) }

    context 'when suggested by same user twice' do
      it 'ensures uniqueness of user_id within scope of post_id' do
        suggestion_three.valid?
        expect(suggestion_three.errors.full_messages.to_sentence).to include('User has already been taken')
      end
    end
  end
end
