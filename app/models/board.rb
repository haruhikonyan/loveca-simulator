# == Schema Information
#
# Table name: boards
#
#  id                    :bigint           not null, primary key
#  turn                  :integer          not null
#  phase                 :integer          not null
#  active_player         :integer          not null
#  player1_deck          :integer          default([]), not null, is an Array
#  player2_deck          :integer          default([]), not null, is an Array
#  player1_left_member   :integer
#  player1_center_member :integer
#  player1_right_member  :integer
#  player2_left_member   :integer
#  player2_center_member :integer
#  player2_right_member  :integer
#  battle_id             :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Board < ApplicationRecord
  belongs_to :battle

  validates :turn, presence: true
  validates :phase, presence: true
  validates :active_player, presence: true

  validates :player1_deck, presence: true
  validates :player2_deck, presence: true
end
