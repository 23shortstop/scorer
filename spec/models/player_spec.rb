require "rails_helper"

RSpec.describe Player, type: :model do
  subject { build :player }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :number }
    it { should validate_inclusion_of(:number).in_range(0..99) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :team }
  end

end