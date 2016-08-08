require 'byebug'
module GraphSearch
  class Graph
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

    private

    def []=(index, value)
      @vertices[index - 1] = value
    end

    def load_line(vertex)
      if !self[vertex[0]]
        self[vertex[0]] = []
      end
      self[vertex[0]].push vertex[1]
    end
  end
end
