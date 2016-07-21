require "rails_helper"

RSpec.describe GameEventService do
  describe 'create game event' do
    subject(:game_events) do
      GameEventService.new(game)
      .create(outcome, offender, defender, assistant)
      plate_appearance.game_events
    end

    let! (:game)             { create :game }
    let! (:plate_appearance) { create :plate_appearance, game: game }
    let! (:offender)         { create :player }
    let! (:defender)         { create :player }
    let! (:assistant)        { create :player }

    context 'for a not out outcome' do
      let! (:defender)  { nil }
      let! (:assistant) { nil }
      let  (:outcome)   { :single }

      it 'is espect to create one game event for offender' do
        expect(game_events.size).to eql 1
        expect(game_events.where(outcome: GameEvent.outcomes[outcome],
          player: offender).size).to eql 1
      end
    end

    context 'for an out without assist' do
      let! (:assistant) { nil }
      let  (:outcome)   { :force_out }

      it 'is espect to create events for offender and defender' do
        expect(game_events.size).to eql 2
        expect(game_events.where(outcome: GameEvent.outcomes[outcome],
          player: offender).size).to eql 1
        expect(game_events.where(outcome: GameEvent.outcomes[:put_out],
          player: defender).size).to eql 1
      end
    end

    context 'for an out with assist' do
      let (:outcome) { :force_out }

      it 'is espect to create events for offender, defender and assistant' do
        expect(game_events.size).to eql 3
        expect(game_events.where(outcome: GameEvent.outcomes[outcome],
          player: offender).size).to eql 1
        expect(game_events.where(outcome: GameEvent.outcomes[:put_out],
          player: defender).size).to eql 1
        expect(game_events.where(outcome: GameEvent.outcomes[:assist],
          player: assistant).size).to eql 1
      end
    end

  end
end