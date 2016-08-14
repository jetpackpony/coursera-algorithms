require_relative 'lib/graph'

file = "../graph_data.txt"
#file = "spec/test_data/graph_0.txt"

graph = Graph::Graph.new.load IO.read file
paths = graph.dijkstra_shortest_paths 1

puts paths.inspect

print "Result for target vertices: "
[7,37,59,82,99,115,133,165,188,197].each do |v|; print "#{paths[v]},"; end
puts ""
