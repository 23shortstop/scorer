require "rails_helper"

RSpec.describe PlateAppearance, type: :model do
  subject { build :plate_appearance }

  describe 'validations' do
    it { is_expected.to validate_presence_of :game }
    it { is_expected.to validate_presence_of :batter }
    it { is_expected.to validate_presence_of :pitcher }
    it { is_expected.to validate_presence_of :inning }
    it { is_expected.to validate_presence_of :outs }
  end

  describe 'associations' do
    it { is_expected.to belong_to :game }
    it { is_expected.to belong_to :batter }
    it { is_expected.to belong_to :pitcher }
    it { is_expected.to belong_to :runner_on_first }
    it { is_expected.to belong_to :runner_on_second }
    it { is_expected.to belong_to :runner_on_third }
    it { is_expected.to have_many :pitches }
  end

end
