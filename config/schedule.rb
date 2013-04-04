every :hour do
  file_path = File.join(File.expand_path("../..", __FILE__), "main.rb")
  cmd = "/Users/hexudong/.rvm/rubies/ruby-1.9.3-p286/bin/ruby #{file_path}"
  command cmd
end