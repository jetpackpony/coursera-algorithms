require 'byebug'
require 'set'

module TwoSum
  def self.str_to_set(string)
    string.split("\n").map(&:to_i).to_set
  end

  def self.has_sum?(numbers, sum)
    numbers.each do |x|
      return true if sum - x != x && numbers.include?(sum - x)
    end
    false
  end

  def self.has_range_of_sums?(numbers, sums)
    sums.to_a.inject(0) do |target, sum|
      target += 1 if TwoSum.has_sum? numbers, sum
      target
    end
  end
end
