require_relative "tree_node_copy"

class KnightPathFinder

    attr_reader :starting_position, :considered_position
    attr_accessor :root_node

    #These are the possible moves you can take on a chess board with a knight.
    MOVES = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1] 
    ]

    #Finds all the possible moves from a given position. Excludes out of bounds moves.  
    def self.valid_moves(pos)
        valid = []
        cur_x, cur_y = pos
        MOVES.each do |(dx,dy)|
            new_pos = [cur_x + dx, cur_y + dy]
            valid << new_pos if KnightPathFinder.valid_position?(new_pos)
        end 
        valid 
    end 

    def initialize(starting_position)
        @starting_position = starting_position
        @considered_position = [starting_position]
        build_move_tree
    end 

     def find_path(end_pos)
        target_node = root_node.bfs(end_pos)
        trace_path_back(target_node)
    end

    private

    def build_move_tree
        self.root_node = PolyTreeNode.new(starting_position)
        nodes = [root_node]
        until nodes.empty?
            node = nodes.shift
            new_move_positions(node.value).each do |move|
                new_node = PolyTreeNode.new(move)
                node.add_child (new_node)
                nodes << new_node
            end 
        end 
    end

    def new_move_positions(pos)
        valid_moves = KnightPathFinder.valid_moves(pos)
        new_moves = valid_moves.select {|move| !considered_position.include?(move)}
        considered_position.concat(new_moves)
        new_moves
    end 
   
    

    def trace_path_back(target_node)
        path = []
        observed_node = target_node
        until observed_node.nil?
           path.unshift(observed_node.value) 
           observed_node = observed_node.parent 
        end
        path 
    end 

    def self.get_position
        pos = []
        until pos.length == 2 && KnightPathFinder.valid_position?(pos)
            p "type the position with a comma between the numbers"
            pos = gets.chomp.split(",").map(&:to_i)
        end
        pos 
    end 

    def self.valid_position?(position)
        position.all? {|val| val.between?(0,7)}
    end   
    
    def self.run 
        p "Welcome to KnightPathFinder. Start by typing the starting position and then the ending position to find the path"
        start_pos = KnightPathFinder.get_position
        pathfinder = KnightPathFinder.new(start_pos)
        end_position  = KnightPathFinder.get_position
        path = pathfinder.find_path(end_position)
        p path  
    end 

end 

if __FILE__ == $PROGRAM_NAME
    KnightPathFinder.run
end 





