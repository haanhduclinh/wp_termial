module WpTerminal
  class Terminal
    def self.parse_option
      @options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: ENV=dev bundle exec ruby script/terminal_post.rb [@options]'

        article(opts)
        category(opts)
        date(opts)
        thumbnail(opts)
        url(opts)
        title(opts)
        tags(opts)
        help(opts)
      end.parse!
      @options
    end

    def article(opts)
      opts.on('-aARTICLE', '--article=ARTICLE', 'file as main content') do |n|
        unless File.exist?(n)
          puts 'File not found ~.~'
          exit
        end
        @options[:post] = File.read(n)
      end
    end

    def category(opts)
      message = 'category of your post. Ex: cat1,cat2'
      opts.on('-cCATEGORY', '--cat=CATEGORY', message) do |n|
        @options[:category_arr] = n.split(',')
      end
    end

    def date(opts)
      opts.on('-dDATE', '--date=DATE', 'date of this post') do |n|
        @options[:date] = n
      end
    end

    def thumbnail(opts)
      message = "thumb path of your post. Ex: 'thub.jpg'"
      opts.on('-fTHUMBNAIL', '--thumb=THUMBNAIL', message) do |n|
        unless File.exist?(n)
          puts 'Your thumbnail not found T_T'
          exit
        end
        @options[:thumbnail] = n
      end
    end

    def url(opts)
      opts.on('-uURL', '--url=URL', 'post_url') do |n|
        @options[:url] = n
      end
    end

    def title(opts)
      opts.on('-lTITLE', '--title=TITLE', 'post title') do |n|
        @options[:title] = n.tr('_', ' ')
      end
    end

    def tags(opts)
      message = 'tags of your post. Ex: wp_terminal,wordpress'
      opts.on('-tTAG', '--tag=TAG', message) do |n|
        @options[:tag_arr] = n.split(',')
      end
    end

    def help(opts)
      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end
  end
end
