require "./lib/2sum"

start_time = Time.now
set = TwoSum.str_to_set File.read "../data.txt"

puts "Counting..."
res = TwoSum.has_range_of_sums? set, (-10000..10000)
puts "Result: #{res}"
puts "Done in #{Time.now - start_time}"
