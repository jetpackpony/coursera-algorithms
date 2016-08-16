module Graph
  def self.load(text_data)
    graph = Graph.new
    text_data.split("\n").each do |line|
      load_vertex graph, line.split(/\s+/)
    end
    graph
  end

  def self.load_vertex(graph, edges)
    id = edges.shift.to_i
    vert = graph[id] || Vertex.new
    edges.each do |edge|
      edge = edge.split(",").map(&:to_i)
      vert.add_edge edge[0], edge[1]
    end
    graph[id] = vert
  end
end
