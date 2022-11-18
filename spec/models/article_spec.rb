require 'rails_helper'


RSpec.describe Article, type: :model do
  describe "valid factory" do
    subject { build(:article) }

    it { is_expected.to be_valid }
  end
end
