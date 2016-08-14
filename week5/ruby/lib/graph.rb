require 'byebug'

module Graph
  class Graph

    def initialize
      @vert = []
    end

    def load(text_data)
      text_data.split("\n").each do |line|
        load_vertex line.split(/\s+/)
      end
      self
    end

    def count
      @vert.count
    end

    def get_vertex(index)
      @vert[real_index index]
    end

    def dijkstra_shortest_paths(start_vertex)
      explored = Set.new [start_vertex]
      path_lengths = []
      path_lengths[start_vertex] = 0
      while explored.size < self.count
        lengths = []
        explored.each do |v|
          get_vertex(v).each do |w|
            next if explored.include? w[:vert]
            lengths.push({
              vert: w[:vert],
              length: path_lengths[v] + w[:length]
            })
          end
        end
        min = lengths.sort_by { |a| a[:length] }[0]
        path_lengths[min[:vert]] = min[:length]
        explored << min[:vert]
      end
      path_lengths
    end

    private

    def add_vertex(index, value)
      # If this is a new vertex, init it
      if @vert[real_index index].nil?
        @vert[real_index index] = []
      end

      # If the edge doesn't exist yet, add it and the opposite one
      if !edge_exists(index, value[:vert])
        @vert[real_index index].push value
        add_vertex value[:vert], { vert: index, length: value[:length] }
      end
    end

    def edge_exists(vert1, vert2)
      return false if get_vertex(vert1).nil?

      get_vertex(vert1).each do |edge|
        return true if edge[:vert] == vert2
      end
      false
    end

    def real_index(index)
      index - 1
    end

    def load_vertex(edges)
      id = edges.shift.to_i
      edges.each do |edge|
        edge = edge.split(",").map(&:to_i)
        add_vertex id, {
          vert: edge[0],
          length: edge[1]
        }
      end
    end
  end
end
