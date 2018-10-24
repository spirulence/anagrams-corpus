require_relative 'anagrams'

describe AnagramStore do
  context '#anagrams_of' do
    it 'adds and retrieves words' do
      'crepitus cuprites pictures piecrust'.split.each do |word|
        subject.add_word word
      end

      expect(subject.anagrams_of('pictures')).to match_array('crepitus cuprites pictures piecrust'.split)
    end

    it 'does not include other words' do
      'crepitus cuprites pictures piecrust apple'.split.each do |word|
        subject.add_word word
      end

      expect(subject.anagrams_of('pictures')).to match_array('crepitus cuprites pictures piecrust'.split)
    end

    it 'does not duplicate words' do
      'crepitus cuprites pictures pictures piecrust apple'.split.each do |word|
        subject.add_word word
      end

      expect(subject.anagrams_of('pictures')).to match_array('crepitus cuprites pictures piecrust'.split)
    end
  end

  context '#each_set' do
    it 'does not include words without anagrams' do
      'crepitus cuprites pictures piecrust apple'.split.each do |word|
        subject.add_word word
      end

      result = []
      subject.each_set do |anagram_set|
        result << anagram_set
      end

      expect(result).to match_array(['crepitus cuprites pictures piecrust'.split])
    end
  end
end