require "./lib/graph"

#text_data =
#  <<-GRAPH
#  1 2
#  2 3
#  3 1
#  2 5
#  5 6
#  6 7
#  7 8
#  8 6
#  3 9
#  3 12
#  12 9
#  9 10
#  10 11
#  11 12
#  9 11
#  9 8
#  10 7
#  13 7
#  13 10
#  13 14
#  10 14
#  11 14
#
#  GRAPH

filename = "../graph_data.txt"
text_data  = File.read(filename)
start_time = Time.now

puts "Start loading the graph"
log = GraphSearch::Log.new "puts"
graph = GraphSearch::Graph.new(log).load text_data
puts "Completed loading the graph in #{Time.now - start_time}"
puts "Loaded graph with #{graph.size} vertices"


start_time = Time.now
puts "Start computing SCCs"
graph.compute_sccs


counts = graph.get_sccs.map{ |x| x.size }.sort
counts = counts[-5, 5] if counts.size > 4

puts "5 largest SCCs:"
puts counts.reverse.inspect
puts "Done in #{Time.now - start_time}"
