require_relative 'helper'
require_relative 'statistics'
require 'libsvm'

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

# This library is namespaced.
problem = Libsvm::Problem.new
parameter = Libsvm::SvmParameter.new
parameter.cache_size = 10 # in megabytes
parameter.eps = 0.001
parameter.c = 10

def test(problem, parameter, ar)
  training_set, testing_set = Helper.in_sets(ar, 0.8)

  labels = []
  vectors = []

  training_set.each do |vector|
    label = vector[0]
    vector = vector[2..vector.size-1]
    labels << label
    vectors  << vector
  end

  #File.open('trainig_set.txt', 'w') { |file| file.write(training_set.map{|s| s.join(', ')}.join("\n")) }

  examples = vectors.map {|ary| Libsvm::Node.features(ary) }

  problem.set_examples(labels, examples)
  model = Libsvm::Model.train(problem, parameter)

  # Testing the model

  true_val = 0
  false_val = 0
  vectors = []
  testing_set.each do |vector|
    label = vector[0]
    vector = vector[2..vector.size-1]

    pred = model.predict(Libsvm::Node.features(*vector))

    label == pred ? true_val+=1 : false_val+=1

    vectors << vector.unshift(pred)
  end

  #File.open('testing_set.txt', 'w') { |file| file.write(vectors.map{|s| s.join(', ')}.join("\n")) }

  return [true_val, false_val,  true_val*1.0/false_val]
end




agr_a = 0
agr_b = 0

eps = 0.0001
min = 1.1
max = 1.2

while eps < 10 do
  eps*=4
  c = 0.01
while c < 100 do
    c*=4
    agr_a = agr_b = 0
    10.times do
      problem = Libsvm::Problem.new

#:svm_type = Parameter::C_SVC, for the type of SVM
#:kernel_type = Parameter::LINEAR, for the type of kernel
#:cost = 1.0, for the cost or C parameter
#:gamma = 0.0, for the gamma parameter in kernel
#:degree = 1, for polynomial kernel
#:coef0 = 0.0, for polynomial/sigmoid kernels
#:eps = 0.001, for stopping criterion
#:nr_weight = 0, for C_SVC
#:nu = 0.5, used for NU_SVC, ONE_CLASS and NU_SVR. Nu must be in (0,1]
#:p = 0.1, used for EPSILON_SVR
#:shrinking = 1, use the shrinking heuristics
#:probability = 0, use the probability estimates


      parameter = Libsvm::SvmParameter.new
      #parameter.kernel_type = Libsvm::KernelType::LINEAR
        #POLY = nil #value is unknown, used for indexing.
        #RBF = nil #value is unknown, used for indexing.
        #SIGMOID = nil #value is unknown, used for indexing.
        #PRECOMPUTED = nil #value is unknown, used for indexing.
      parameter.cache_size = 10 # in megabytes
      parameter.eps = eps
      parameter.c = c
      #parameter.degree = degree
      #parameter.coef0 = 0.1


      a,b,cc = test(problem, parameter, ar)
      agr_a = agr_a + a
      agr_b = agr_b + b
    end
    res = agr_a*1.0/agr_b
    if res < min
      min = res
      puts 'min'
      puts eps
      puts c
      puts agr_a
      puts agr_b
      puts res
      puts agr_a.to_f/(agr_a.to_f+agr_b)
    end

    if res > max
      max = res
      puts 'max'
      puts eps
      puts c
      puts agr_a
      puts agr_b
      puts res
      puts agr_a.to_f/(agr_a.to_f+agr_b)
    end
  end
end
