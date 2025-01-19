class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]

  # POST /boards or /boards.json
  def create
    @board = board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: "board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.fetch(:board, {})
    end
end
