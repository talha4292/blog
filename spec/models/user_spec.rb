# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:eighteen_plus_user) { create(:user, :user, birthday: '2003-09-25') }
  let(:not_eighteen_plus_user) { build(:user, :user, birthday: '2006-09-25') }

  describe 'associations tests' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'enum tests' do
    it { is_expected.to define_enum_for(:role).with_values(%i[user moderator admin]) }
  end

  describe 'validations tests' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:birthday) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(15) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(15) }
    it { is_expected.to validate_length_of(:username).is_at_least(6).is_at_most(20) }
    it { is_expected.to validate_length_of(:about).is_at_most(50) }
  end

  describe 'custom validation tests' do
    it 'confirms user is atleast 18 years old' do
      expect(eighteen_plus_user).to be_valid
    end

    it 'confirms user is not atleast 18 years old' do
      not_eighteen_plus_user.valid?
      expect(not_eighteen_plus_user.errors.full_messages.to_sentence).to match('You must be over 18 years old')
    end
  end
end
