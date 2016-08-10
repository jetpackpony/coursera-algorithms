require_relative './lib/graph_search'
=begin
text_data = <<-GRAPH.gsub(/^\s*/, '')
    1 2
    2 3
    3 1
    2 4
    4 5
    5 6
    6 7
    7 5
    3 8
    3 11
    11 8
    8 9
    9 10
    10 11
    8 10
    8 7
    9 6

  GRAPH
=end
text_data = IO.read ARGV[0]
start_time = Time.now

puts "Start loading the graph"
graph = GraphSearch::Graph.new.load text_data
puts "Completed loading the graph in #{Time.now - start_time} seconds"
puts "Loaded graph with #{graph.count} vertices"


start_time = Time.now
puts "Start computing SCCs"
graph.compute_sccs

counts = graph.get_sccs.map(&:count).sort
counts = counts.slice(-5, 5) if counts.count > 4

puts counts.reverse.inspect
