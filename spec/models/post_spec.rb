# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user, :user) }
  let!(:post_one) { create(:post, :approved, user_id: user.id, updated_at: 1.day.ago) }
  let!(:post_two) { create(:post, :approved, user_id: user.id, updated_at: 1.hour.ago) }

  describe 'associations tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'enum tests' do
    it { is_expected.to define_enum_for(:status).with_values(%i[unapproved approved]) }
  end

  describe 'scope tests' do
    it 'return posts order by updated_at timestamp descendingly (recent to oldest)' do
      expect(described_class.descending).to eq [post_two, post_one]
    end
  end

  describe 'validations tests' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
  end
end
