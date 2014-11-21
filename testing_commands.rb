load 'board.rb'
a = Board.new


a.render
a[[5,0]].slides
a[[5,0]].jumps
a[[5,0]].perform_slide([4,1])
a[[2,1]].jumps
a[[4,1]].perform_slide([3,2])
a[[2,1]].jumps
a[[3,2]].jumps
a[[2,1]].perform_jump([4,3])
a.render



load 'board.rb'
a = Board.new
a.place_piece(:white, [2,0])
a.render
a[[2,0]].perform_moves([[1,1]])



load 'checkers_game.rb'
a = Game.new
a.board.place_piece(:black, [1,1])
a.board.place_piece(:black, [3,3])
a.board.place_piece(:black, [5,5])
a.board.place_piece(:white, [6,6])
a.board.render
a.board[[6,6]].perform_moves([[4,4], [2,2], [0,0]])



load 'board.rb'
a = Board.new
a.starting_positions
b = a.dup
a.render
b.render
a.object_id
b.object_id
a[[0,1]].object_id
b[[0,1]].object_id
