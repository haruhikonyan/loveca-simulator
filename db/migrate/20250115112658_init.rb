class Init < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      # member/live
      t.integer :card_type, null: false
      t.string :name, null: false
      t.string :code, null: false
      t.integer :cost, null: false, default: 0
      t.integer :blade_heart, null: false, default: 0
      # TODO: 各色追加
      t.integer :heart, null: false, default: 0
      t.integer :score, null: false, default: 0

      t.timestamps
    end
    create_table :decks do |t|
      t.string :name
      t.integer :card_ids, null: false, array: true, default: []

      t.timestamps
    end
    # TODO: devise で作成
    create_table :users do |t|
      t.string :name, null: false
    end
    create_table :battles do |t|
      t.string :name
      t.json :player1_deck, null: false
      t.json :player2_deck, null: false

      t.references :player1, null: false, foreign_key: { to_table: :users }
      t.references :player2, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    create_table :boards do |t|
      t.integer :turn, null: false
      t.integer :phase, null: false
      t.integer :active_player, null: false

      t.integer :player1_deck, null: false, array: true, default: []
      t.integer :player2_deck, null: false, array: true, default: []

      t.integer :player1_left_member, null: true
      t.integer :player1_center_member, null: true
      t.integer :player1_right_member, null: true

      t.integer :player2_left_member, null: true
      t.integer :player2_center_member, null: true
      t.integer :player2_right_member, null: true
      # TODO: プレイマット全て再現
      t.references :battle

      t.timestamps
    end
  end
end
