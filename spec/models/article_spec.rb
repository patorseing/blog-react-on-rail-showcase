# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'valid factory' do
    subject { build(:article) }

    it { is_expected.to be_valid }
  end

  describe 'validations' do
    before { create(:article) }

    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
    it { is_expected validate_length_of(:body).is_at_least(10).on(:create) }
  end

  describe 'associations' do
    it { is_expected have_many(:comments).dependent(:destroy) }
  end
end
