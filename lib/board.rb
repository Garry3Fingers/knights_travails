# frozen_string_literal: true

# This class is a chessboard
class ChessBoard
  attr_reader :board

  def initialize
    @board = [
      %w[a1 a2 a3 a4 a5 a6 a7 a8],
      %w[b1 b2 b3 b4 b5 b6 b7 a8],
      %w[c1 c2 c3 c4 c5 c6 c7 c8],
      %w[d1 d2 d3 d4 d5 d6 d7 d8],
      %w[e1 e2 e3 e4 e5 e6 e7 e8],
      %w[f1 f2 f3 f4 f5 f6 f7 f8],
      %w[g1 g2 g3 g4 g5 g6 g7 g8],
      %w[h1 h2 h3 h4 h5 h6 h7 h8]
    ]
  end
end
