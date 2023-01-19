# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  def user1
    create(:user, :user)
  end

  def user3
    create(:user, :user)
  end

  let(:user2) { create(:user, :user) }
  let(:post) { create(:post, :approved, user_id: user1.id) }
  let!(:report_one) { create(:report, reportable: post, user_id: user2.id, updated_at: 1.day.ago) }
  let(:report_two) { create(:report, reportable: post, user_id: user3.id, updated_at: 1.hour.ago) }
  let(:report_three) { build(:report, reportable: post, user_id: user2.id) }

  describe 'associations tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:reportable) }
  end

  describe 'scope tests' do
    it 'return reports order by updated_at timestamp descendingly (recent to oldest)' do
      expect(described_class.descending).to eq [report_two, report_one]
    end
  end

  describe 'validations test' do
    it { is_expected.to validate_presence_of(:text) }

    context 'when reported by same user twice' do
      it 'ensures uniqueness of user_id within scope of reportable_id and reportable_type' do
        report_three.valid?
        expect(report_three.errors.full_messages.to_sentence).to include('User has already been taken')
      end
    end
  end
end
