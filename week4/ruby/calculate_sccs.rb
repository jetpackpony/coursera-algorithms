require_relative './lib/graph'

text_data = IO.read ARGV[0]
start_time = Time.now

puts "Start loading the graph"
graph = GraphSearch::Graph.new(GraphSearch::Log.new("puts")).load text_data
puts "Completed loading the graph in #{Time.now - start_time} seconds"
puts "Loaded graph with #{graph.count} vertices"

start_time = Time.now
puts "Start computing SCCs"
graph.compute_sccs

counts = graph.get_sccs.map(&:count).sort
counts = counts.slice(-5, 5) if counts.count > 4

puts counts.reverse.inspect
