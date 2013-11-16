require_relative 'helper'
require_relative 'statistics'


ar, vector = Helper.get_normalized_data

#(2..17).each do |i|
#  puts i
#  puts (correlate(ar[1], ar[i]))
#  puts '----'
#end

# 3 14 15 17


#test_ar = [2,3,6,9,13,14,15,17]
#test_ar = [2,6,9,13]
#
#test_ar.each do |i|
#  params = (correlate(ar[1], ar[i])).to_s
#  puts i.to_s + ' =>  ' + params
#  #puts (correlate(ar[0], ar[i]))
#end
#
#
#test_ar.each do |i|
#  test_ar.each do |j|
#    next if i >= j
#    res = (correlate(ar[i], ar[j]))
#    if res > 0.4 || res < - 0.4
#      puts i,j
#      puts res
#      puts '----'
#    end
#  end
#end


puts vector

#?  ar[0,1] ~ ar[2..17]


