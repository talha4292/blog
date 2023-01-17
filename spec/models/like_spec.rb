# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { create(:user, :user) }
  let(:post) { create(:post, :approved, user_id: user1.id) }
  let!(:like_one) { create(:like, likeable: post, user_id: user1.id, updated_at: 1.day.ago) }
  let!(:like_two) { create(:like, likeable: post, user_id: user2.id, updated_at: 1.hour.ago) }
  let(:like_three) { build(:like, likeable: post, user_id: user1.id) }

  def user2
    create(:user, :user)
  end

  describe 'associations tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:likeable) }
  end

  describe 'scope tests' do
    it 'return likes order by updated_at timestamp descendingly (recent to oldest)' do
      expect(described_class.descending).to eq [like_two, like_one]
    end
  end

  describe 'validation tests' do
    context 'when liked by same user twice' do
      it 'ensures uniqueness of user_id within scope of likeable_id and likeable_type' do
        like_three.valid?
        expect(like_three.errors.full_messages.to_sentence).to include('User has already been taken')
      end
    end
  end
end
