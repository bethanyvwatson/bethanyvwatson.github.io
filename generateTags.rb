class GenerateTagIndexPages
  def generate
    tags = open('tags_to_generate.txt').read
    tags.each_line do |t|
      open("tag/#{t.strip}.md", 'a') { |f| print_file_contents(t, f) unless f.size > 0 }
    end
  end

  def print_file_contents(tag, file)
    file.puts '---'
    file.puts 'layout: tagpage'
    file.puts "title: \"Tag: #{tag}\""
    file.puts "tag: #{tag}"
    file.puts '---'
  end

  GenerateTagIndexPages.new.generate
end