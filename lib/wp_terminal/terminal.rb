module WpTerminal
  class Terminal
    def self.parse_option
      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: ENV=dev bundle exec ruby script/terminal_post.rb [options]"

        opts.on("-aARTICLE", "--article=ARTICLE", "file as main content") do |n|
          unless File.exist?(n)
            puts "File not found ~.~"
            exit
          end
          options[:post] = File.read(n)
        end

        opts.on("-cCATEGORY", "--cat=CATEGORY", "category of your post. Ex: eric,haanhduclinh") do |n|
          options[:category_arr] = n.split(',')
        end

        opts.on("-dDATE", "--date=DATE", "date of this post") do |n|
          options[:date] = n
        end

        opts.on("-fTHUMBNAIL", "--thumb=THUMBNAIL", "thumbnail path of your post. Ex: '~/source/eric.jpg'") do |n|
          unless File.exist?(n)
            puts "Your thumbnail not found T_T"
            exit
          end
          options[:thumbnail] = n
        end

        opts.on("-uURL", "--url=URL", "post_url") do |n|
          options[:url] = n
        end

        opts.on("-lTITLE", "--title=TITLE", "post title") do |n|
          options[:title] = n.gsub('_',' ')
        end

        opts.on("-tTAG", "--tag=TAG", "tags of your post. Ex: wp_terminal,wordpress") do |n|
          options[:tag_arr] = n.split(',')
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end.parse!
      options
    end
  end
end
