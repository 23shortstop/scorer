require 'rails_helper'

RSpec.describe LineupPlayer, :type => :model do
  subject { build :lineup_player }

  describe 'validations' do
    it { is_expected.to validate_presence_of :batting_position }
    it { is_expected.to validate_presence_of :fielding_position }
    it { is_expected.to validate_presence_of :player }
    it { should validate_inclusion_of(:batting_position).in_range(1..9) }
    it { should validate_inclusion_of(:fielding_position).in_range(1..9) }
    it { should validate_uniqueness_of(:batting_position).scoped_to(:lineup_id) }
    it { should validate_uniqueness_of(:fielding_position).scoped_to(:lineup_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :player }
    it { is_expected.to belong_to :lineup }
  end
end
