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

ActiveRecord::Schema.define(version: 20160628004832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string "league_name"
  end

  create_table "players", force: :cascade do |t|
    t.integer "team_id"
    t.string  "name"
    t.integer "number"
    t.string  "photo"
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

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

end
