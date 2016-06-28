require "rails_helper"

RSpec.describe Game, type: :model do
  subject { build :game }

  describe 'validations' do
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :home_team_id }
    it { is_expected.to validate_presence_of :away_team_id }
    it { is_expected.to validate_presence_of :scorer }
    it { is_expected.to validate_presence_of :season }
  end

  describe 'associations' do
    it { is_expected.to belong_to :home_team }
    it { is_expected.to belong_to :away_team }
    it { is_expected.to belong_to :scorer }
    it { is_expected.to belong_to :season }
  end

end