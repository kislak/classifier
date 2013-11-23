require 'spreadsheet'
require 'pry'

class Helper
  def self.get_data
    rows = []
    Spreadsheet.open('data.xls') do |book|
      book.worksheet('Sheet1').each do |row|
        break if row[0].nil?
        row[0]=row[0].value.to_i
        rows << row
      end
    end

    ar = []

    rows.each do |row|
      row.each_with_index do |value, index|
        ar[index] ||=[]
        ar[index] << value
      end
    end

    ar
  end

  def self.get_sanitized_data
    get_data
    # TODO exclude outlier.

  end

  def self.get_normalized_data
    ar = get_sanitized_data
    ar_normal = []
    vector = []
    ar.each do |x_ar|
      n = x_ar.max.abs
      n = x_ar.min if x_ar.min.abs > n
      n = 1 if n == 0
      vector << n
      ar_normal << x_ar.map{|e| e/n.to_f}
    end

    return [ar_normal, vector]
  end


  def self.in_sets(ar, x_rand)
    training_set = []
    testing_set = []

    ar[0].each_with_index do |e, index|
      vector = []
      (0...ar.size).each do |i|
        vector << ar[i][index]
      end

      if rand < x_rand
        training_set << vector
      else
        testing_set << vector
      end
    end

    return training_set, testing_set
  end

end

