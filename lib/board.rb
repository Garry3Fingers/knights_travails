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

# This class calculates a traversal on a chessboard
class TraversalProccesor
  attr_reader :traversal_board
  attr_accessor :starting_position, :end_position

  def initialize(args)
    @starting_position = args[:starting_position]
    @end_position = args[:end_position]
    @traversal_board = args[:board]
  end

  def print_path
    find_path.each_pair { |key, value| puts "#{key}: #{value}" }
  end

  private

  def find_path
    arr = traverse(traversal_board).last.flatten
    path = {}
    until arr.empty?
      c = arr.pop
      r = arr.pop
      path[traversal_board[r][c]] = [r, c]
    end
    path
  end

  def traverse(board, visited = [], r = row, c = column)
    queue = [[r, c]]

    until queue.empty?
      current = queue.shift
      next if current.first.negative? ||
              current.first > board.length - 1 ||
              current[1].negative? ||
              current[1] > board.length - 1

      visited << current
      return visited if board[current.first][current[1]] == end_position

      queue.push([current.first + 2, current[1] + 1, current])
      queue.push([current.first + 2, current[1] - 1, current])
      queue.push([current.first - 2, current[1] + 1, current])
      queue.push([current.first - 2, current[1] - 1, current])
      queue.push([current.first + 1, current[1] + 2, current])
      queue.push([current.first + 1, current[1] - 2, current])
      queue.push([current.first - 1, current[1] + 2, current])
      queue.push([current.first - 1, current[1] - 2, current])
    end
  end

  def column
    traversal_board.each do |arr|
      column = arr.index(starting_position)
      return column unless column.nil?
    end
  end

  def row
    traversal_board.index { |arr| arr.include?(starting_position) }
  end
end

# This module is a wrapper for the class TraversalProccesor class
module TraversalProccesorWrapper
  def self.traversal_proccesor(move, board)
    TraversalProccesor.new(
      starting_position: move[:starting_position],
      end_position: move[:end_position],
      board:
    )
  end
end

TraversalProccesorWrapper.traversal_proccesor(
  Knight.new.knight_moves('d4', 'a1'),
  ChessBoard.new.board
).print_path
