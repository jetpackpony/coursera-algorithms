module GraphSearch
  class Graph

    getter :vertices
    def initialize
      @vertices = [] of Array(Int32)
    end

    def [](id)
      @vertices[id - 1]
    end

    def []=(index, value)
      @vertices[index - 1] = value
    end

    def count
      @vertices.size
    end

    def load(text_data)
      text_data = text_data.strip

      # Initialize the vertices array
      text_data.split(/\s+/).map{ |x| x.to_i }    # get all the vertices numbers
        .sort[-1, 1][0]                           # get the last vertex number
        .times do                                 # init vert array with empty
          @vertices.push [] of Int32
        end

      text_data.split("\n").each do |line|
        load_line line.strip.split(%r{\s+}).map { |x| x.to_i }
      end
      self
    end

    def each_with_index(&block)
      @vertices.each_with_index do |vert, index|
        yield vert, index + 1
      end
    end

    def reverse
      new_vert = [] of Array(Int32)
      @vertices.size.times do
        new_vert.push [] of Int32
      end

      self.each_with_index do |edges, vert|
        edges.each do |edge|
          new_vert[edge - 1].push vert
        end
      end
      @vertices = new_vert
    end

    private def load_line(vertex)
      self[vertex[0]].push vertex[1]
    end
  end
end
