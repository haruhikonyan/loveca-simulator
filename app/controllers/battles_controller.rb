class BattlesController < ApplicationController
  before_action :set_battle, only: %i[ show edit update destroy ]

  # GET /battles or /battles.json
  def index
    @battles = Battle.all
  end

  # GET /battles/1 or /battles/1.json
  def show
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles or /battles.json
  def create
    # @battle = Battle.new(battle_params)
    @battle = Battle.new(
      name: "test",
      player1: User.first,
      player2: User.last,
      player1_deck: Deck.first.card_ids.map.with_index { |id, index| { card_id: id, sequence: index } },
      player2_deck: Deck.first.card_ids.map.with_index { |id, index| { card_id: id, sequence: index } }
    )

    respond_to do |format|
      if @battle.save
        format.html { redirect_to @battle, notice: "Battle was successfully created." }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battles/1 or /battles/1.json
  def update
    respond_to do |format|
      if @battle.update(battle_params)
        format.html { redirect_to @battle, notice: "Battle was successfully updated." }
        format.json { render :show, status: :ok, location: @battle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1 or /battles/1.json
  def destroy
    @battle.destroy!

    respond_to do |format|
      format.html { redirect_to battles_path, status: :see_other, notice: "Battle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
      @board = @battle.boards.last
      @cards = Card.all.index_by(&:id)
    end

    # Only allow a list of trusted parameters through.
    def battle_params
      params.fetch(:battle, {})
    end
end
