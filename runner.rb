require_relative 'anagrams'

require 'nokogiri'
require 'open-uri'

anagrams = AnagramStore.new

urls_html = Nokogiri::HTML(open('urls.html'))

urls_html.css("a").map do |link|
  puts "opening #{link['href']}"
  open(link['href']) do |f|
    gz = Zlib::GzipReader.new(f)

    gz.each_line do |line|
      ngram = line.split(/\t/)[0]
      ngram.split.each { |word| anagrams.add_word(word) }
    end

    gz.close
  end
end

open('found_anagrams.txt', 'w') do |out_file|
  anagrams.each_set do |set|
    out_file.write(set.join(" ") + "\n")
  end
end
