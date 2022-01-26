class PolyTreeNode

    attr_reader :value, :parent 

    def initialize(value)
        @value = value 
        @parent = nil
        @children = []
    end 

    def children
        @children.dup
    end 

    def parent=(new_parent)
        old_parent = @parent 
        old_parent._children.delete(self) if !old_parent.nil?
        if !new_parent.nil?
            @parent = new_parent 
            @parent._children << self 
        else
            @parent = new_parent
        end  
    end 

    def add_child(child_node)
        child_node.parent = self
    end 

    def remove_child(child_node)
        if children.include?(child_node)
            child_node.parent = nil
        else 
            raise "not a child"
        end 
    end 

    def dfs(target_value)
        return nil if self.nil?
        return self if self.value == target_value
        children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?  
        end 
        nil
    end  

    def bfs(target_value)
        queue = [self]
        until queue.empty? 
            el = queue.shift
            return el if el.value == target_value
            el.children.each do |child|
                queue << child 
            end 
        end
        nil 
    end 

    protected

    def _children
        @children
    end 
end


