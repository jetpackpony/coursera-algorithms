require_relative "./lib/median_maintainer"

fileName = ARGV[0]

mm = MedianMaintainer.new
sum = 0
IO.read(fileName).strip.split("\n").map(&:to_i).each do |x|
  mm.add x
  sum += mm.median
end

puts "The sum is #{sum}"
puts "Mod 1000 is #{sum % 10000}"
