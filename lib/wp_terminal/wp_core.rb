require 'rubypress'

module WpTerminal
  class WpCore
    def initialize(host:, username:, password:, use_ssl: nil)
      @client = Rubypress::Client.new(
        host: host,
        username: username,
        password: password,
        use_ssl: use_ssl
      )
    end

    def post(title:, content:, options: {})
      terms_names = {
        category: options[:category_arr],
        post_tag: options[:tag_arr]
      }.select { |_k, v| v }

      content = {
        post_status: 'publish',
        post_date: options[:date] || Time.now,
        post_content: content,
        post_title: title,
        post_name: options[:post_url],
        post_author: options[:author_id],
        post_type: 'post',
        post_thumbnail: options[:attachment_id],
        terms_names: terms_names
      }.select { |_k, v| v }

      @client.newPost(
        blog_id: 0, # 0 unless using WP Multi-Site, then use the blog id
        content: content
      )
    end

    def upload_image(image_file_path, default_picture_id = nil)
      image_type = upload_type(image_file_path)
      return nil unless image_type
      res = @client.uploadFile(
        data:
          {
            name: File.basename(image_file_path),
            type: image_type,
            bits: XMLRPC::Base64.new(File.open(image_file_path).read)
          }
      )
      res['id'] ? res['id'] : default_picture_id
    end

    def set_thumbnail
      # http://stackoverflow.com/questions/12355922/set-featured-image-for-wordpress-post-via-xml-rpc
      get_media_item['attachment_id']
    end

    def get_media_item(img_id, blog_id = 0)
      @client.getMediaItem(blog_id: blog_id, attachment_id: img_id)
    end

    private

    def upload_type(image_file_path)
      type = get_file_extend(image_file_path)
      return nil unless type
      "image/#{type}"
    end

    def get_file_extend(image_file_path)
      accepted_formats = ['.jpg', '.png', '.PNG', '.JPEG']
      check = accepted_formats.include? File.extname(image_file_path)
      return nil unless check
      File.extname(image_file_path).delete('.')
    end
  end
end
