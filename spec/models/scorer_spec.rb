require "rails_helper"

RSpec.describe Scorer, type: :model do
  subject { build :scorer }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  describe 'associations' do
    it { is_expected.to have_many :sessions }
    it { is_expected.to have_many :games }
  end

end