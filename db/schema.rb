# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_15_112658) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.string "name"
    t.json "player1_deck", null: false
    t.json "player2_deck", null: false
    t.bigint "player1_id", null: false
    t.bigint "player2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player1_id"], name: "index_battles_on_player1_id"
    t.index ["player2_id"], name: "index_battles_on_player2_id"
  end

  create_table "boards", force: :cascade do |t|
    t.integer "turn", null: false
    t.integer "phase", null: false
    t.integer "active_player", null: false
    t.integer "player1_deck", default: [], null: false, array: true
    t.integer "player2_deck", default: [], null: false, array: true
    t.integer "player1_left_member"
    t.integer "player1_center_member"
    t.integer "player1_right_member"
    t.integer "player2_left_member"
    t.integer "player2_center_member"
    t.integer "player2_right_member"
    t.bigint "battle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_boards_on_battle_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "card_type", null: false
    t.string "name", null: false
    t.string "code", null: false
    t.integer "cost", default: 0, null: false
    t.integer "blade_heart", default: 0, null: false
    t.integer "heart", default: 0, null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.integer "card_ids", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
  end

  add_foreign_key "battles", "users", column: "player1_id"
  add_foreign_key "battles", "users", column: "player2_id"
end
