require 'set'

class AnagramStore
  def initialize
    @data = Hash.new{ |h, k| h[k] = Set.new }
  end

  def add_word(word)
    key = word.each_byte.sort
    @data[key] << word
  end

  def anagrams_of(word)
    key = word.each_byte.sort
    @data[key].sort if @data[key].count > 1
  end

  def each_set
    @data.each_value do |value|
      yield value.sort if value.count > 1
    end
  end
end