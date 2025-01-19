class BattleChannel < ApplicationCable::Channel
  def subscribed
    stream_from "battle_channel"
  end

  def speak(data)
    ActionCable.server.broadcast "battle_channel", message: data["message"]
  end

  def end_turn(data)
    battle = Battle.find(data["battle_id"])
    board = battle.boards.last

    # 新しいボードを作成（ここは実際のゲームロジックに応じて調整）
    new_board = board.dup
    new_board.turn += 1
    new_board.active_player = board.active_player == 1 ? 2 : 1
    new_board.save!

    # 更新された盤面をブロードキャスト
    html = ApplicationController.renderer.render(
      partial: "battles/board",
      locals: {
        battle: battle,
        board: new_board,
        cards: Card.all.index_by(&:id)
      }
    )

    ActionCable.server.broadcast(
      "battle_channel",
      {
        type: "board_update",
        html: html
      }
    )
  end

  def play_card(data)
    battle = Battle.find(data["battle_id"])
    board = battle.boards.last

    # 新しいボードを作成
    new_board = board.dup

    # プレイヤーと位置に基づいてカードを配置
    player = data["player"].to_i
    position = data["position"]
    sequence = data["sequence"].to_i

    # カードを場に配置
    member_position = "player#{player}_#{position}_member"
    new_board[member_position] = sequence

    # 山札からカードを除去
    deck = player == 1 ? new_board.player1_deck : new_board.player2_deck
    deck.delete(sequence)

    if player == 1
      new_board.player1_deck = deck
    else
      new_board.player2_deck = deck
    end

    new_board.save!

    # 更新された盤面をブロードキャスト
    html = ApplicationController.renderer.render(
      partial: "battles/board",
      locals: {
        battle: battle,
        board: new_board,
        cards: Card.all.index_by(&:id)
      }
    )

    ActionCable.server.broadcast(
      "battle_channel",
      {
        type: "board_update",
        html: html
      }
    )
  end
end
