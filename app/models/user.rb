# == Schema Information
#
# Table name: users
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class User < ApplicationRecord
  has_many :player1_battles, foreign_key: :player1_id, class_name: "Battle"
  has_many :player1_battles, foreign_key: :player2_id, class_name: "Battle"
  has_many :decks

  validates :name, presence: true
end
