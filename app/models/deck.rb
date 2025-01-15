# == Schema Information
#
# Table name: decks
#
#  id         :bigint           not null, primary key
#  name       :string
#  card_ids   :integer          default([]), not null, is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Deck < ApplicationRecord
  validates :name, presence: true
  validates :card_ids, presence: true
end
