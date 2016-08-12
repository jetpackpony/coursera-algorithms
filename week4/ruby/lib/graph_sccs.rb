module GraphSearch
  module SCCs

    def compute_sccs
      @sccs = []
      count_finishing_times
      traverse_sccs
    end

    def get_sccs
      @sccs
    end

    private

    def count_finishing_times
      log "  - reversing the graph" + "(#{Time.now - prev_time}) seconds"
      reverse
      log "  - starting counting finishing times" +
        "(#{Time.now - prev_time}) seconds"
      @finishing_times = []
      @explored = []
      @one_percent = (self.count / 100.0).ceil
      self.each_index do |vert|
        next if @explored.include? vert
        dfs vert
      end
      reverse
      log "  - starting counting finishing times"
    end

    def dfs(vert)
      stack = [vert]
      while stack.length > 0 do
        if @explored.count % @one_percent == 0
          log "    - #{@explored.count / @one_percent}% done " +
            "(#{Time.now - prev_time}) seconds"
        end

        v = stack.pop
        if !@explored.include? v
          @explored.push v
          stack.push v
          self[v].each do |edge|
            next if @explored.include? edge
            stack.push edge
          end
        else
          if !@finishing_times.include? v
            @finishing_times.push v
          end
        end
      end
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
      stack = [vert]
      while stack.length > 0 do
        if @explored.count % @one_percent == 0
          log "    - #{@explored.count / @one_percent}% done " +
            "(#{Time.now - prev_time}) seconds"
        end

        v = stack.pop
        @current_scc.push v
        self[v].each do |edge|
          next if @explored.include? edge
          @explored.push edge
          stack.push edge
        end
      end
    end
  end
end
