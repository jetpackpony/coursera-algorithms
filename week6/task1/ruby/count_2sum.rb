require_relative "./lib/2sum"

start_time = Time.now
set = TwoSum.str_to_set IO.read "data.txt"
puts "Counting..."
res = TwoSum.has_range_of_sums? set, (-5..5)
puts "Result: #{res}"
puts "Done in #{Time.now - start_time}"


