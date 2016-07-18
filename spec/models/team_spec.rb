require "rails_helper"

RSpec.describe Team, type: :model do
  subject { build :team }

  describe 'validations' do
    it { is_expected.to validate_presence_of :team_name }
    it { is_expected.to validate_presence_of :city }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many :seasons }
    it { is_expected.to have_many :players }
    it { is_expected.to have_many :games }
  end

end
