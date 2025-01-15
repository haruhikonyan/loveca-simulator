# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  card_type   :integer          not null
#  name        :string           not null
#  code        :string           not null
#  cost        :integer          default(0), not null
#  blade_heart :integer          default(0), not null
#  heart       :integer          default(0), not null
#  score       :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Card < ApplicationRecord
  enum card_type: { member: 0, live: 1 }

  validates :card_type, presence: true
  validates :name, presence: true
  validates :code, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :blade_heart, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :heart, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
