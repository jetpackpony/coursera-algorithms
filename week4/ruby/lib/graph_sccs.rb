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
      log "  - counting finishing times"
      reverse

      @finishing_times = []
      @explored = Set.new
      @ten_percent = (self.count / 10.0).ceil
      self.each_index do |vert|
        next if @explored.include? vert
        dfs vert
      end
      reverse
    end

    def dfs(vert)
      stack = [vert]
      while stack.length > 0 do
        v = stack.pop
        if !@explored.include? v
          if @explored.size % @ten_percent == 0
            log "    - #{@explored.size / @ten_percent}0% done "
          end
          @explored.add v
          stack.push v
          self[v].each do |edge|
            next if @explored.include? edge
            stack.push edge
          end
        else
          @finishing_times.push v
        end
      end
    end

    def traverse_sccs
      log "  - collecting sccs"
      @explored = Set.new
      @finishing_times.reverse.each do |vert|
        next if @explored.include? vert
        @current_scc = []
        dfs_collect vert
        @sccs.push @current_scc
      end
    end

    def dfs_collect(vert)
      @explored.add vert
      stack = [vert]
      while stack.length > 0 do
        if @explored.size % @ten_percent == 0
          log "    - #{@explored.size / @ten_percent}0% done "
        end

        v = stack.pop
        @current_scc.push v
        self[v].each do |edge|
          next if @explored.include? edge
          @explored.add edge
          stack.push edge
        end
      end
    end
  end
end
