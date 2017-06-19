require 'dotenv/load'
require 'stringex'
require 'config'
require 'optparse'

module WpTerminal
  autoload :WpCore, './lib/wp_terminal/wp_core'
  autoload :Terminal, './lib/wp_terminal/terminal'
  autoload :WpTerminal, './lib/version'

  class Core
    Config.load_and_set_settings(Config.setting_files('./config', ENV['ENV']))

    def initialize
      @wp = WpTerminal::WpCore.new(
        host: Settings.wordpress.host,
        username: Settings.wordpress.username,
        password: Settings.wordpress.password,
        use_ssl: Settings.wordpress.use_ssl
      )
      @options = WpTerminal::Terminal.parse_option
    end

    def run!
      if post_from_file?
        post_from_file
      else
        post_from_terminal
      end
    end

    def submit_post(title:, post:, options: {})
      post_data = {
        date: options[:date] || Time.now,
        title: title,
        content: post,
        post_url: options[:post_url] || to_url(title),
        author_id: Settings.wordpress.use_ssl,
        category_arr: options[:category_arr],
        tag_arr: options[:tag_arr],
        attachment_id: options[:attachment_id]
      }.select { |_k, v| v }

      response = @wp.post(post_data)
      if response.to_i > 0
        { result: true, body: 'Post created' }
      else
        { result: false, body: 'Post failed' }
      end
    rescue => e
      { result: false, body: e.message }
    end

    private

    def post_from_file?
      @options[:post] && @options[:title]
    end

    def post_from_file
      title = @options[:title]
      post = @options[:post]

      attachment_id = if @options[:thumbnail]
                        @wp.upload_image(@options[:thumbnail], default_picture_id = nil)
                      else
                        nil
                      end

      post_options = {
        date: @options[:date],
        post_url: @options[:url],
        category_arr: @options[:category_arr],
        tag_arr: @options[:tag_arr],
        attachment_id: attachment_id
      }.select { |_k, v| v }

      submit_post(
        title: title,
        post: post,
        options: post_options
      )
    end

    def post_from_terminal
      p "Put your title:"
      title = gets.chomp
      p "Put your content:"
      content = []
      type = gets

      if type.start_with?("BEGIN")
        until type.start_with?("END\n")
          content << type unless type == "BEGIN\n"
          type = gets
        end
      else
        content << type.chomp
      end

      submit_post(
        title: title,
        post: content.join(' ')
      )
    end

    def to_url(str)
      url = str.to_url
      if url.size > 80
        url.slice(0, 80)
      else
        url
      end
    end
  end
end
