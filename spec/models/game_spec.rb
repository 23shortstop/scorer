require "rails_helper"

RSpec.describe Game, type: :model do
  subject { build :game }

  describe 'validations' do
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :hosts }
    it { is_expected.to validate_presence_of :guests }
    it { is_expected.to validate_presence_of :scorer }
    it { is_expected.to validate_presence_of :season }
  end

  describe 'associations' do
    it { is_expected.to belong_to :hosts }
    it { is_expected.to belong_to :guests }
    it { is_expected.to belong_to :scorer }
    it { is_expected.to belong_to :season }
    it { is_expected.to have_many :plate_appearances }
  end

end
