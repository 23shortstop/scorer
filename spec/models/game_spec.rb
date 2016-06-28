require "rails_helper"

RSpec.describe Game, type: :model do
  subject { build :game }

  describe 'validations' do
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :home_team }
    it { is_expected.to validate_presence_of :away_team }
    it { is_expected.to validate_presence_of :scorer }
    it { is_expected.to validate_presence_of :season }
  end

  describe 'associations' do
    it { is_expected.to have_one :home_team }
    it { is_expected.to have_one :away_team }
    it { is_expected.to have_one :scorer }
    it { is_expected.to have_one :season }
  end

end