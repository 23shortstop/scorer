require "rails_helper"

RSpec.describe PlateAppearanceService do

  describe 'create next plate appearance' do
    subject(:plate_appearance) do
      PlateAppearanceService.new(game).next_plate_appearance
    end

    let (:game) { create :game }
    let (:previous_batter) { lineup.sample }
    let (:lineup) { game.home_team_lineup }

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
        expect(plate_appearance.offense_team).to eql game.away_team
        expect(plate_appearance.defense_team).to eql game.home_team
        expect(plate_appearance.batter).to eql game.away_team_lineup.first
        expect(plate_appearance.pitcher).to eql game.home_team_pitcher
      end
    end

    context 'for the game in progress' do
      let! (:previous_plate_appearance) do
        create(:plate_appearance, batter: previous_batter)
      end
      let! (:event) do
        previous_plate_appearance.game_events.create!(
          outcome: :double, player: previous_batter)
      end
      let (:current_batter_index) { (lineup.index(previous_batter) + 1) % 9 }
      let (:current_batter) { lineup[current_batter_index] }

      it 'is expect to crate a new plate appearance with
       the previous batter as runner on the second base' do
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql previous_batter
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.batter).to eql current_batter
      end
    end

    context 'after the third out for the home team' do
      let! (:previous_plate_appearance) do
        create(:plate_appearance, batter: previous_batter, outs: 2)
      end
      let! (:event) do
        previous_plate_appearance.game_events.create!(
          outcome: :force_out, player: previous_batter)
      end
      let (:lineup) { game.away_team_lineup }

      it 'is expect to switch teams' do
        expect(plate_appearance.inning).to eql previous_plate_appearance.inning
        expect(plate_appearance.outs).to eql 0
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql nil
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.offense_team).to eql game.home_team
        expect(plate_appearance.defense_team).to eql game.away_team
      end
    end

    context 'after the third out for the away team' do
      let! (:previous_plate_appearance) do
        create(:plate_appearance, batter: previous_batter, outs: 2)
      end
      let! (:event) do
        previous_plate_appearance.game_events.create!(
          outcome: :force_out, player: previous_batter)
      end

      it 'is expect to switch teams and increment innings' do
        expect(plate_appearance.inning).to eql (previous_plate_appearance.inning + 1)
        expect(plate_appearance.game).to eql game
        expect(plate_appearance.outs).to eql 0
        expect(plate_appearance.runner_on_first).to eql nil
        expect(plate_appearance.runner_on_second).to eql nil
        expect(plate_appearance.runner_on_third).to eql nil
        expect(plate_appearance.offense_team).to eql game.away_team
        expect(plate_appearance.defense_team).to eql game.home_team
      end
    end
  end

end
