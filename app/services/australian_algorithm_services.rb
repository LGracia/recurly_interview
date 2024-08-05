class AustralianAlgorithmServices
  WEIGHTING_FACTORS = [10, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

  def initialize(identification_number:)
    @identification_number = identification_number.tr(' ', '')
  end

  def valid?
    first_element = @identification_number.chr.to_i - 1
    @identification_number[0] = first_element.to_s

    (@identification_number.each_char.map.with_index { |x, i| x.to_i * WEIGHTING_FACTORS[i] }.sum % 89).zero?
  end
end
