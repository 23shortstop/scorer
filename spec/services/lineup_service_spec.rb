require "rails_helper"

RSpec.describe LineupService do
  describe 'fill lineups' do
    subject(:create_lineups) { LineupService.new(game).create(hosts_data, guests_data) }

    let (:game)        { create(:game, hosts: hosts, guests: guests, status: :not_started) }
    let (:home_team)   { create :team }
    let (:guest_team)  { create :team }
    let (:hosts)       { create :lineup }
    let (:guests)      { create :lineup }
    let (:hosts_data)  { create(:filled_lineup, team: home_team).lineup_players.map &lineup_data }
    let (:guests_data) { create(:filled_lineup, team: guest_team).lineup_players.map &lineup_data }

    let (:lineup_data) do
      ->(player) do
        { batting_position: player.batting_position, fielding_position: player.fielding_position,
          player_id: player.player_id }
      end
    end

    context 'by list of lineup players' do
      it 'is espect to create lineups and start a game' do
        create_lineups

        expect(game.hosts.players.size).to eql hosts_data.size
        expect(game.guests.players.size).to eql guests_data.size
        expect(game.status).to eql 'in_progress'
        expect(game.plate_appearances.first.persisted?).to be_truthy
      end
    end
  end
end
