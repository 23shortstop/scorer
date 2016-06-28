require "rails_helper"

RSpec.describe Player, type: :model do
  subject { build :player }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :number }
  end

  describe 'associations' do
    it { is_expected.to belong_to :team }
  end

end