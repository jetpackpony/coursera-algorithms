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
      i = 0
      @one_percent = (self.count / 100.0).ceil
      self.each_index do |vert|
        next if @explored.include? vert
        dfs vert
      end
      reverse
      log "  - starting counting finishing times"
    end

    def dfs(vert)
      @explored.push vert
      if @explored.count % @one_percent == 0
        log "    - #{@explored.count / @one_percent}% done " +
          "(#{Time.now - prev_time}) seconds"
      end
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
      if @explored.count % @one_percent == 0
        log "    - #{@explored.count / @one_percent}% done " +
          "(#{Time.now - prev_time}) seconds"
      end
      @current_scc.push vert
      self[vert].each do |edge|
        next if @explored.include? edge
        dfs_collect edge
      end
    end

  end
end
