# == Schema Information
#
# Table name: battles
#
#  id           :bigint           not null, primary key
#  name         :string
#  player1_deck :json             not null
#  player2_deck :json             not null
#  player1_id   :bigint           not null
#  player2_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Battle < ApplicationRecord
  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User"
  has_many :boards

  validates :player1_deck, presence: true
  validates :player2_deck, presence: true
  validates :player1_id, presence: true
  validates :player2_id, presence: true

  def get_card_id_by_sequence(player_num, sequence)
    deck = player_num == 1 ? player1_deck : player2_deck
    deck_entry = deck.find { |entry| entry["sequence"] == sequence }
    deck_entry&.fetch("card_id")
  end
end
