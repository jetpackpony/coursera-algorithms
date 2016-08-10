require 'byebug'
module GraphSearch
  class Graph
    include Enumerable

    def initialize
      @vertices = []
    end

    def load(text_data)
      text_data.split("\n").each do |line|
        load_line line.split(/\s+/).map(&:to_i)
      end
      self
    end

    def [](id)
      @vertices[id - 1]
    end

    def []=(index, value)
      @vertices[index - 1] = value
    end

    def count
      @vertices.count
    end

    def each(&block)
      @vertices.each do |vert|
        next if vert.nil?
        block.call(vert)
      end
    end

    def each_with_index(&block)
      @vertices.each_with_index do |vert, index|
        next if vert.nil?
        block.call(vert, index + 1)
      end
    end

    def each_index(&block)
      @vertices.each_with_index do |vert, index|
        next if vert.nil?
        block.call(index + 1)
      end
    end

    def compute_sccs
      @sccs = []
      count_finishing_times
      traverse_sccs
    end

    def get_sccs
      @sccs
    end

    def reverse
      new_vert = []
      self.each_with_index do |edges, vert|
        raise "the edges for #{vert} are nil for some reason" if edges.nil?
        new_vert[vert - 1] = [] if !new_vert[vert - 1]
        edges.each do |edge|
          edge -= 1
          new_vert[edge] = [] if !new_vert[edge]
          new_vert[edge].push vert
        end
      end
      @vertices = new_vert
    end

    private

    def count_finishing_times
      reverse
      @finishing_times = []
      @explored = []
      self.each_index do |vert|
        next if @explored.include? vert
        dfs vert
      end
      reverse
    end

    def dfs(vert)
      @explored.push vert
      raise "Tried to reffer to vert #{vert} while nil" if self[vert].nil?
      self[vert].each do |edge|
        next if @explored.include? edge
        dfs edge
      end
      @finishing_times.push vert
    end

    def traverse_sccs
      @explored = []
      @finishing_times.reverse.each do |vert|
        next if @explored.include? vert
        @current_scc = []
        dfs_collect vert
        @sccs.push @current_scc
      end
    end

    def dfs_collect(vert)
      @explored.push vert
      @current_scc.push vert
      self[vert].each do |edge|
        next if @explored.include? edge
        dfs_collect edge
      end
    end

    def load_line(vertex)
      self[vertex[0]] = [] if !self[vertex[0]]
      self[vertex[1]] = [] if !self[vertex[1]]
      self[vertex[0]].push vertex[1]
    end
  end
end
