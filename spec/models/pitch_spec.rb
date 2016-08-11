require 'rails_helper'

RSpec.describe Pitch, :type => :model do
  subject { build :pitch }

  describe 'validations' do
    it { is_expected.to validate_presence_of :outcome }
    it { is_expected.to validate_presence_of :plate_appearance }
  end

  describe 'associations' do
    it { is_expected.to belong_to :plate_appearance }
  end

  describe 'outcomes' do
    it { is_expected.to define_enum_for(:outcome).
      with([:ball, :strike, :foul, :fair, :hit_by_pitch]) }
  end
end
