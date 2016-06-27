require "rails_helper"

RSpec.describe Season, type: :model do
  subject { build :season }

  describe 'validations' do
    it { is_expected.to validate_presence_of :league }
    it { is_expected.to validate_presence_of :year }
  end

  describe 'associations' do
    it { is_expected.to belong_to :league }
  end

end