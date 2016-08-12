module GraphSearch
  class Log
    def initialize(@output : String)
    end

    def log(text)
      case @output
      when "puts"
        puts text
      else
      end
    end
  end

  class Graph
    getter :vertices

    def initialize(@log = Log.new("none"))
      @vertices = [] of Array(Int32)
      @finishing_times = [] of Int32
      @explored = Set(Int32).new
      @sccs = [] of Array(Int32)
      @current_scc = [] of Int32
      @one_percent = 0
    end

    def [](id)
      @vertices[id - 1]
    end

    def []=(index, value)
      @vertices[index - 1] = value
    end

    def size
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
      @one_percent = (@vertices.size / 100.00).ceil.to_i

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

    def each_index(&block)
      @vertices.each_with_index do |vert, index|
        yield index + 1
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

    def compute_sccs
      count_finishing_times
      traverse_sccs
    end

    def get_sccs
      @sccs
    end

    private def log(text)
      @log.log text
    end

    private def load_line(vertex)
      self[vertex[0]].push vertex[1]
    end

    private def count_finishing_times
      log "  - reversing the graph"
      reverse
      log "  - starting counting finishing times"
      @finishing_times = [] of Int32
      @explored = Set(Int32).new
      self.each_index do |vert|
        next if @explored.includes? vert
        dfs vert
      end
      reverse
      log "  - completed counting finishing times"
    end

    private def dfs(vert)
      # Log the completeness
      if @explored.size % @one_percent == 0
        log "    - #{@explored.size / @one_percent}% complete"
      end

      # Do the thing
      @explored.add vert
      self[vert].each do |edge|
        next if @explored.includes? edge
        dfs edge
      end
      @finishing_times.push vert
    end

    private def traverse_sccs
      log "  - starting mapping sccs"
      @explored = Set(Int32).new
      @finishing_times.reverse.each do |vert|
        next if @explored.includes? vert
        @current_scc = [] of Int32
        dfs_collect vert
        @sccs.push @current_scc
      end
      log "  - completed mapping sccs"
    end

    private def dfs_collect(vert)
      # Log the completeness
      if @explored.size % @one_percent == 0
        log "    - #{@explored.size / @one_percent}% complete"
      end

      # Do the thing
      @explored.add vert
      @current_scc.push vert
      self[vert].each do |edge|
        next if @explored.includes? edge
        dfs_collect edge
      end
    end

  end
end
