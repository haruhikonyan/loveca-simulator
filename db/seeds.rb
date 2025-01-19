# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
member1 = Card.find_or_create_by!(card_type: :member, name: "高坂 穂乃果", code: "test-1", cost: 1, blade_heart: 0, heart: 1, score: 0)
member2 = Card.find_or_create_by!(card_type: :member, name: "南ことり", code: "test-2", cost: 2, blade_heart: 1, heart: 1, score: 0)
live1 = Card.find_or_create_by!(card_type: :live, name: "スノハレ", code: "test-3", score: 2)

Deck.find_or_create_by!(name: "デッキ1", card_ids: [ member1.id, member1.id, member1.id, member2.id, member2.id, live1.id, live1.id ])

User.find_or_create_by!(name: 'ゲスト1')
User.find_or_create_by!(name: 'ゲスト2')
