module Graph
  def self.shortest_paths(graph, start)
    explored = Set.new [start]
    path_lengths = []
    path_lengths[start] = 0
    while explored.size < graph.count
      lengths = []
      explored.each do |v|
        graph.get_vertex(v).edges.each do |vert_id, length|
          next if explored.include? vert_id
          lengths.push({
            vert_id: vert_id,
            length: path_lengths[v] + length
          })
        end
      end
      min = lengths.sort_by { |a| a[:length] }[0]
      path_lengths[min[:vert_id]] = min[:length]
      explored << min[:vert_id]
    end
    path_lengths
  end
end
