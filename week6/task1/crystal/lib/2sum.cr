module TwoSum
  def self.str_to_set(string)
    string.strip.split("\n").map { |x| x.to_i64 }.to_set
  end

  def self.has_sum?(numbers, sum)
    sum = sum.to_i64
    numbers.each do |x|
      return true if sum - x != x && numbers.includes?(sum - x)
    end
    false
  end

  def self.has_range_of_sums?(numbers, sums)
    sums.to_a.select { |sum| TwoSum.has_sum? numbers, sum }.size
  end
end
