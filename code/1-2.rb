#!/usr/bin/ruby

require 'minitest/autorun'
require 'set'

def two_missing(count, stream)
	# count of elements
	n = count+2

	# init result
	result = Array.new

	# sum and sum of squares
	alpha = n*(n+1)/2
	beta = n*(n+1)*(2*n+1)/6

	#iterate
	stream.each do |arg| 
		alpha-=arg
		beta-=(arg*arg)
	end

	# calculate  missing number:w
	i_1= (alpha+Math.sqrt(2*beta-(alpha*alpha)))/2
	i_2 = alpha - i_1
	return Set.new([i_1.to_i,i_2.to_i])

end

Struct.new("Stream",:len,:stream,:expected)

class StreamTest < Minitest::Test 

	@@test_data = [
		Struct::Stream.new(3,[1,2,4],Set.new([3,5])),
		Struct::Stream.new(4,[2,3,4,5],Set.new([1,6])),
		Struct::Stream.new(5,[1,3,4,5,6],Set.new([2,7]))
	]

	def test_streams
		@@test_data.each do |data|
			result = two_missing(data.len,data.stream)
			assert_equal(data.expected,result)
		end
	end
end



