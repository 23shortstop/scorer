require "rails_helper"

RSpec.describe GameEventService do
  describe 'create game event' do
    subject(:game_events) do
      GameEventService.new(game).create({ outcome: outcome, offender_base: offender_base,
        defender_position: defender_position, assistant_position: assistant_position })
      plate_appearance.game_events
    end

    let! (:plate_appearance) do
      create :plate_appearance, game: game, half_inning: :top, batter: offender
    end
    let! (:game)               { create :game }
    let! (:offender_base)      { nil }
    let! (:defender_position)  { rand(1..9) }
    let! (:assistant_position) { rand(1..9) }
    let  (:offender)           { game.guests.players.sample }
    let  (:defender)           { game.hosts.fielders.get_by_position(defender_position) }
    let  (:assistant)          { game.hosts.fielders.get_by_position(assistant_position) }

    context 'for a not out outcome' do
      let! (:defender_position)  { nil }
      let! (:assistant_position) { nil }
      let  (:outcome)            { :single }

      it 'is espect to create one game event for offender' do
        expect(game_events.size).to eql 1
        expect(game_events.where(outcome: GameEvent.outcomes[outcome],
          player: offender).size).to eql 1
      end
    end

    context 'for an out without assist' do
      let! (:assistant_position) { nil }
      let  (:outcome)            { :force_out }

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
