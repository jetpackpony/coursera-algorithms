require_relative './lib/graph'
require 'byebug'

=begin
text = <<-GRAPH
1 2 4 5
2 1 3 4
3 2 4
4 1 2 3 5
5 1 4
GRAPH
=end

text = IO.read("graph_data.txt")

time = prev = Time.now

original_graph = Graphs::Graph.new.load text
minimum_cut = original_graph.count
iterations = original_graph.count

puts "Calculating minimum cut in a graph of #{original_graph.count} elements"
iterations.times do
  graph = original_graph.copy
  graph.random_contract

  minimum_cut = [minimum_cut, graph.first.edges.count].min
  puts "Speed: #{Time.now - prev}"
  prev = Time.now
end

puts "Minimun cut: #{minimum_cut}"
puts "Calculated over #{iterations} iterations, took #{Time.now - time} seconds"

