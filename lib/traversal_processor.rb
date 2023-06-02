# frozen_string_literal: true

require_relative 'board'
require_relative 'knight'

# This class calculates a traversal on a chessboard
class TraversalProcessor
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
module TraversalProcessorWrapper
  def self.traversal_processor(move, board)
    TraversalProcessor.new(
      starting_position: move[:starting_position],
      end_position: move[:end_position],
      board:
    )
  end
end

TraversalProcessorWrapper.traversal_processor(
  Knight.new.knight_moves('d4', 'a1'),
  ChessBoard.new.board
).print_path
