require 'dotenv/load'
require 'stringex'

module WpTerminal
  class Core
    autoload :WpCore, 'wp_terminal/wp_core'
    autoload :WpTerminal, 'version'
    Config.load_and_set_settings(Config.setting_files('./config', ENV['ENV']))

    def initialize
      @wp = WpTerminal::WpCore.new(
        host: Settings.wordpress.host,
        username: Settings.wordpress.username,
        password: Settings.wordpress.password,
        use_ssl: Settings.wordpress.use_ssl
      )
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
      @wp.post post_data
      # (date: Time.now, title:, content:, post_url:, author_id:, category_arr:, tag_arr:, attachment_id:)
    end

    private

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
