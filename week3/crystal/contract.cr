require "./graph"
require "option_parser"

iterations = 200
step_speed = false
show_progress = true
filename = "../graph_data.txt"

OptionParser.parse! do |parser|
  parser.banner = "Usage: contract [arguments]"
  parser.on("-i COUNT", "--iterations=COUNT", "The number of iterations to perform") { |count| iterations = count.to_i }
  parser.on("-f FILE", "--filename=FILE", "The file with text representation of the graph") { |file| filename = file }
  parser.on("-ss", "--step_speed", "Show speed at every step") { step_speed = true }
  parser.on("-np", "--no-progress", "Don't show the progress") { show_progress = false }
  parser.on("-h", "--help", "Show this help") { puts parser }
end

time = prev = Time.now

#text = <<-GRAPH
#1 2 4 5
#2 1 3 4
#3 2 4
#4 1 2 3 5
#5 1 4
#
#GRAPH

text = File.read(filename)

original_graph = Graphs::Graph.new.load text
minimum_cut = original_graph.size
ten_persent = (iterations / 10).ceil

puts "Calculating minimum cut in a graph of #{original_graph.size} elements over #{iterations} iterations"
iterations.times do |iter|
  graph = original_graph.copy
  graph.random_contract

  minimum_cut = [minimum_cut, graph.first.edges.size].min
  puts "Speed: #{Time.now - prev}" if step_speed
  puts "#{iter / ten_persent}0% done" if show_progress && (iter % ten_persent == 0)
  prev = Time.now
end

puts "Minimun cut: #{minimum_cut}"
puts "Calculated over #{iterations} iterations, took #{Time.now - time}"

