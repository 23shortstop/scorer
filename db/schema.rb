# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160719083300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_events", force: :cascade do |t|
    t.integer "outcome"
    t.integer "plate_appearance_id"
    t.integer "player_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer  "season_id"
    t.integer  "scorer_id"
    t.datetime "date"
    t.integer  "hosts_id"
    t.integer  "guests_id"
  end

  add_index "games", ["guests_id"], name: "index_games_on_guests_id", using: :btree
  add_index "games", ["hosts_id"], name: "index_games_on_hosts_id", using: :btree
  add_index "games", ["scorer_id"], name: "index_games_on_scorer_id", using: :btree
  add_index "games", ["season_id"], name: "index_games_on_season_id", using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string "league_name"
  end

  create_table "lineup_players", force: :cascade do |t|
    t.integer "batting_position"
    t.integer "fielding_position"
    t.integer "lineup_id"
    t.integer "player_id"
  end

  create_table "lineups", force: :cascade do |t|
    t.integer "team_id"
  end

  add_index "lineups", ["team_id"], name: "index_lineups_on_team_id", using: :btree

  create_table "pitches", force: :cascade do |t|
    t.integer "outcome"
    t.integer "plate_appearance_id"
  end

  create_table "plate_appearances", force: :cascade do |t|
    t.integer "game_id"
    t.integer "inning"
    t.integer "outs"
    t.integer "batter_id"
    t.integer "pitcher_id"
    t.integer "runner_on_first_id"
    t.integer "runner_on_second_id"
    t.integer "runner_on_third_id"
    t.integer "half_inning"
  end

  add_index "plate_appearances", ["batter_id"], name: "index_plate_appearances_on_batter_id", using: :btree
  add_index "plate_appearances", ["game_id"], name: "index_plate_appearances_on_game_id", using: :btree
  add_index "plate_appearances", ["pitcher_id"], name: "index_plate_appearances_on_pitcher_id", using: :btree
  add_index "plate_appearances", ["runner_on_first_id"], name: "index_plate_appearances_on_runner_on_first_id", using: :btree
  add_index "plate_appearances", ["runner_on_second_id"], name: "index_plate_appearances_on_runner_on_second_id", using: :btree
  add_index "plate_appearances", ["runner_on_third_id"], name: "index_plate_appearances_on_runner_on_third_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer "team_id"
    t.string  "name"
    t.integer "number"
    t.string  "photo"
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "scorers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "league_id"
    t.integer "year"
  end

  add_index "seasons", ["league_id"], name: "index_seasons_on_league_id", using: :btree

  create_table "seasons_teams", force: :cascade do |t|
    t.integer "season_id"
    t.integer "team_id"
  end

  add_index "seasons_teams", ["season_id"], name: "index_seasons_teams_on_season_id", using: :btree
  add_index "seasons_teams", ["team_id"], name: "index_seasons_teams_on_team_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.integer  "authenticable_id"
    t.string   "authenticable_type"
    t.string   "token"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "sessions", ["authenticable_type", "authenticable_id"], name: "index_sessions_on_authenticable_type_and_authenticable_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "city"
    t.string "logo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      default: "", null: false
    t.string   "password"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "plate_appearances", "players", column: "batter_id"
  add_foreign_key "plate_appearances", "players", column: "pitcher_id"
  add_foreign_key "plate_appearances", "players", column: "runner_on_first_id"
  add_foreign_key "plate_appearances", "players", column: "runner_on_second_id"
  add_foreign_key "plate_appearances", "players", column: "runner_on_third_id"
end
