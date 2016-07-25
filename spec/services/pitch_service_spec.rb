require "rails_helper"

RSpec.describe PitchService do
  describe 'create pitch' do
    subject(:pitch) do
      PitchService.new(game).create(outcome)
      plate_appearance.pitches.last
    end

    let! (:game)             { create :game }
    let! (:plate_appearance) do
      create :plate_appearance, game: game,
      batter: batter, half_inning: :top
    end
    let  (:batter)           { create :player }

    context 'for an outcome' do
      let  (:outcome)   { Pitch.outcomes.keys.sample }

      it 'is espect to create a pitch' do
        expect(pitch.persisted?).to be_truthy
        is_expected.to be_a Pitch
        expect(pitch.outcome).to eql outcome
      end
    end

    context 'for a fourth ball' do
      let! (:pitches) do
        create_list(:pitch, 3, plate_appearance: plate_appearance,
          outcome: :ball)
      end
      let  (:outcome) { 'ball' }

      it 'is espect to create a walk game event' do
        expect(pitch.persisted?).to be_truthy
        is_expected.to be_a Pitch
        expect(pitch.outcome).to eql outcome
        expect(plate_appearance.game_events.size).to eql 1
        expect(plate_appearance.game_events.where(
          outcome: GameEvent.outcomes[:walk],
          player: batter).size).to eql 1
      end
    end

    context 'for an third strike' do
      let! (:pitches) do
        create_list(:pitch, 2, plate_appearance: plate_appearance,
          outcome: :strike)
      end
      let  (:outcome) { 'strike' }
      let  (:catcher) { game.hosts.fielders.get_by_position(2) }

      it 'is espect to create a strike_out game event' do
        expect(pitch.persisted?).to be_truthy
        is_expected.to be_a Pitch
        expect(pitch.outcome).to eql outcome
        expect(plate_appearance.game_events.size).to eql 2
        expect(plate_appearance.game_events.where(
          outcome: GameEvent.outcomes[:strike_out],
          player: batter).size).to eql 1
        expect(plate_appearance.game_events.where(
          outcome: GameEvent.outcomes[:put_out],
          player: catcher).size).to eql 1
      end
    end
  end
end
