require 'rails_helper'

RSpec.describe GameEvent, :type => :model do
  subject { build :game_event }

  describe 'validations' do
    it { is_expected.to validate_presence_of :outcome }
    it { is_expected.to validate_presence_of :player }
    it { is_expected.to validate_presence_of :plate_appearance }
  end

  describe 'associations' do
    it { is_expected.to belong_to :plate_appearance }
    it { is_expected.to belong_to :player }
  end

  describe 'outcomes' do
    it { is_expected.to define_enum_for(:outcome).
      with([:assist, :put_out,
            :single, :double, :triple, :home_run,
            :safe_on_first, :safe_on_second, :safe_on_third, :scored,
            :hold_first, :hold_second, :hold_third,
            :walk,
            :sacrifice_fly, :sacrifice_bunt,
            :force_out, :tag_out, :fly_out, :fielders_choice]) }
  end
end
