require 'spreadsheet'

class Helper
  def self.get_data
    rows = []
    Spreadsheet.open('data.xls') do |book|
      book.worksheet('Sheet1').each do |row|
        break if row[0].nil?
        binding.pry

        row[i].nil?
        rows << row
      end
    end
    rows
  end
end