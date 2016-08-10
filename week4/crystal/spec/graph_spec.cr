require "../lib/graph"
require "spec"

def graph_init(graph_id=0)
  if graph_id == 0
    text =
      <<-GRAPH
      7 1 
      1 4 
      4 7
      9 7
      9 3
      3 6
      6 9
      8 6
      2 8
      5 2
      8 5

      GRAPH
  else
    text =
      <<-GRAPH
      1 2
      2 3
      3 1
      2 5
      5 6
      6 7
      7 8
      8 6
      3 9
      3 12
      12 9
      9 10
      10 11
      11 12
      9 11
      9 8
      10 7
      13 7
      13 10
      13 14
      10 14
      11 14

      GRAPH
  end

  text = text.gsub(/^\s*/, "")
  GraphSearch::Graph.new.load text
end

describe GraphSearch::Graph do

  describe "#load" do
    it "stores outgoing connections properly" do
      graph = graph_init
      graph[7].should contain 1
      graph[9].should contain 7
      graph[9].should contain 3
      graph[5].should contain 2
      graph[5].should_not contain 8
    end
  end

  describe "#[], #[]=, size" do
    it "adds the vertices correctly" do
      graph = graph_init
      graph[1] = [1,2,3]
      graph[4] = [4,5,6]
      graph[1].should eq [1,2,3]
      graph[4].should eq [4,5,6]
    end

    it "counts the vertices correctly" do
      graph = graph_init
      graph.size.should eq 9
    end
  end

  describe "#reverse" do
    it "reverses the edges correctly" do
      graph = graph_init
      graph.reverse
      graph[7].should contain 9
      graph[7].should contain 4
      graph[9].should contain 6
      graph[8].should contain 2
    end
  end

  describe "#compute_sccs" do
    it "computes strongly connected components correctly" do
      graph = graph_init
      graph.compute_sccs
      graph.get_sccs.each{ |x| x.sort! }
      graph.get_sccs.should contain [1,4,7]
      graph.get_sccs.should contain [3,6,9]
      graph.get_sccs.should contain [2,5,8]
    end

    it "computes strongly connected components correctly" do
      graph_1 = graph_init 1
      graph_1.compute_sccs
      graph_1.get_sccs.each{ |x| x.sort! }
      graph_1.get_sccs.should contain [1,2,3]
      graph_1.get_sccs.should contain [9,10,11,12]
      graph_1.get_sccs.should contain [6,7,8]
      graph_1.get_sccs.should contain [5]
      graph_1.get_sccs.should contain [13]
      graph_1.get_sccs.should contain [14]
    end
  end
end
