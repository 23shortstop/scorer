require "rails_helper"

RSpec.describe League, type: :model do
  subject { build :league }

  describe 'validations' do
    it { is_expected.to validate_presence_of :league_name }
  end

  describe 'associations' do
    it { is_expected.to have_many :seasons }
  end

end