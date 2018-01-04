class TitleBracketsValidator < ActiveModel::Validator
  def validate(movie_title)
    if !brackets_closed_properly?(movie_title)
      movie_title.errors.add(:title, "has unclosed or incorrectly closed brackets")
    elsif brackets_empty?(movie_title)
      movie_title.errors.add(:title, "has empty brackets")
    end
  end

  def brackets_closed_properly?(validatable_object)
    str = validatable_object.title
    bin = []
    opening_br = ['(', '[', '{']
    closing_br = [')', ']', '}']
    str.each_char do |char|
      if opening_br.index(char)
        index = opening_br.index(char)
        bin <<  closing_br[index]
      end
      return false if closing_br.index(char) && char != bin.pop
    end
    bin.empty?
  end

  def brackets_empty?(validatable_object)
    str = validatable_object.title
    opening_br = ['(', '[', '{']
    closing_br = [')', ']', '}']
    i = 0
    while i < str.length
      if opening_br.include?(str[i]) && closing_br.include?(str[i+1])
        return true
      end
      i += 1
    end
    false
  end
end
