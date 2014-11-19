#def valid_move?
#  new_tile has to be within board
#  new_tile cannot be occupied by a piece of the same color
#
#end

load "board.rb"
a = Board.new
bishop1 = a[[1,6]]
bishop1.pos = [4,4]
bishop1.moves


load "board.rb"
a = Board.new
rook1 = a[[0,3]]
rook1.pos = [4,4]
rook1.moves


exit


#have begin-rescue-end loop w/ user input

load "board.rb"
a = Board.new
a.move([1,7],[3,7])
a.render
a.make_move([7,4], [5,6])
a.render
a.move([5,6], [4,6])


load "board.rb"
a = Board.new
a.make_move([7,4],[4,7])
a.make_move([0,3],[4,6])
a.make_move([0,0],[4,5])
