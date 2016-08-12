module GraphSearch
  module SCCs

    def compute_sccs
      @sccs = collect_sccs calculate_finishing_times
    end

    def get_sccs
      @sccs
    end

    private

    def ten_percent
      (self.count / 10.0).ceil
    end

    def calculate_finishing_times
      log "  - counting finishing times"
      reverse

      finishing_times = []
      explored = Set.new

      self.each_index do |vert|
        next if explored.include? vert
        stack = [vert]
        while stack.length > 0 do
          v = stack.pop
          if !explored.include? v
            if explored.size % ten_percent == 0
              log "    - #{explored.size / ten_percent}0% done "
            end
            explored.add v
            stack.push v
            self[v].each do |edge|
              next if explored.include? edge
              stack.push edge
            end
          else
            finishing_times.push v
          end
        end
      end

      reverse
      finishing_times
    end

    def collect_sccs(finishing_times)
      log "  - collecting sccs"

      explored = Set.new
      sccs = []

      finishing_times.reverse.each do |vert|
        next if explored.include? vert
        current_scc = []
        explored.add vert
        stack = [vert]
        while stack.length > 0 do
          if explored.size % ten_percent == 0
            log "    - #{explored.size / ten_percent}0% done "
          end

          v = stack.pop
          current_scc.push v
          self[v].each do |edge|
            next if explored.include? edge
            explored.add edge
            stack.push edge
          end
        end
        sccs.push current_scc
      end
      sccs
    end
  end
end
