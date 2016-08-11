require 'rails_helper'

RSpec.describe Lineup, :type => :model do
  subject (:lineup) { build :lineup }

  describe 'validations' do
    it { is_expected.to validate_presence_of :team }
  end

  describe 'associations' do
    it { is_expected.to have_many :lineup_players }
    it { is_expected.to belong_to :team }
    it { is_expected.to have_one(:game) }
  end
end
