#def valid_move?
#  new_tile has to be within board
#  new_tile cannot be occupied by a piece of the same color
#
#end

load "board.rb"
a = Board.new
bishop1 = a[[0,2]]
bishop1.pos = [4,4]
bishop1.moves


load "board.rb"
a = Board.new
rook1 = a[[0,3]]
rook1.pos = [4,4]
rook1.moves


exit
