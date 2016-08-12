require "./lib/graph"

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
