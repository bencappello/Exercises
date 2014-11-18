class PolyTreeNode

attr_reader :parent, :value

attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    @parent.children << self unless @parent.nil? || @parent.children.include?(self)
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "Child does not exist!" unless @children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if target_value == @value
    return nil if @children.empty? # unecessary

    @children.each do |child|
      child_search = child.dfs(target_value)
      return child_search unless child_search.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end

    nil
  end

  def trace_path_back
    node = self
    path = [self.value]

    while node.parent
      path << node.parent.value
      node = node.parent
    end

    path.reverse
  end

end
