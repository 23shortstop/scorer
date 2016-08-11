require "rails_helper"

RSpec.describe PlateAppearanceService do

  describe 'create next plate appearance' do
    subject(:plate_appearance) do
      PlateAppearanceService.new(game).create_next
      game.plate_appearances.last
    end

    let (:game)             { create :game, status: :in_progress }
    let (:previous_batter)  { batting_order.sample }
    let (:batting_order)    { game.guests.batters }
    let (:pitcher)          { game.hosts.fielders.first }

    context 'for a new game' do
      it 'is espect to create the first plate appearance' do
        expect(plate_appearance.persisted?).to be_truthy
        is_expected.to be_a PlateAppearance
        expect(plate_appearance.inning).to eql 1
        expect(plate_appearance.game).to eql game
        expect(plate_appearance.outs).to eql 0
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql nil
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.batter).to eql batting_order.first
        expect(plate_appearance.pitcher).to eql pitcher
      end
    end

    context 'for the game in progress' do
      let! (:previous_plate_appearance) do
        create(:plate_appearance, batter: previous_batter, game: game, half_inning: :top)
      end
      let! (:event) do
        previous_plate_appearance.game_events.create!(outcome: :double, player: previous_batter)
      end
      let (:current_batter_index) { (batting_order.index(previous_batter) + 1) % 9 }
      let (:current_batter)       { batting_order[current_batter_index] }

      it 'is expect to create a new plate appearance and set runners on bases' do
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql previous_batter
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.batter).to eql current_batter
      end
    end

    context 'after the third out in the top of the inning' do
      let! (:previous_plate_appearance) do
        create(:plate_appearance, batter: previous_batter, outs: 2, game: game, half_inning: :top)
      end
      let! (:event) do
        create(:game_event, plate_appearance: previous_plate_appearance, outcome: :put_out)
      end

      it 'is expect to switch the half value' do
        expect(plate_appearance.inning).to eql previous_plate_appearance.inning
        expect(plate_appearance.outs).to eql 0
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql nil
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.half_inning).to eql 'bottom'
      end
    end

    context 'after the third out in the bottom' do
      let! (:previous_plate_appearance) do
        create(:plate_appearance, batter: previous_batter,
          outs: 2, game: game, half_inning: :bottom)
      end
      let! (:event) do
        create(:game_event, plate_appearance: previous_plate_appearance, outcome: :put_out)
      end

      it 'is expect to switch half value and increment innings' do
        expect(plate_appearance.inning).to eql (previous_plate_appearance.inning + 1)
        expect(plate_appearance.game).to eql game
        expect(plate_appearance.outs).to eql 0
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql nil
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.half_inning).to eql 'top'
      end
    end
  end

end
