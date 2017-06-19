# Wp Terminal

[![Code Climate](https://codeclimate.com/github/haanhduclinh/wp_terminal.png)](https://codeclimate.com/github/haanhduclinh/wp_terminal)

# Background
- create post for your wordpress website take a long time ? I have simple one if you are developer
# How to setup
+ Install ruby version 2.3
+ create `.env` file with following example:

```
WP_HOST=haanhduclinh.com
WP_AUTHOR_ID=1
WP_USER=xxxx
WP_PASS=xxxx
WP_SSL=true
ENV=dev
```

replace with your username and password. 
If your website use `ssl` => set `WP_SSL=true` if not `WP_SSL=false`
puts this file same level with Gemfile

+ run bundle command `bundle install`
+ run command `ENV=dev bundle exec ruby script/terminal_post.rb`

# Basic command

```
-a, --article=ARTICLE            file as main content
-c, --cat=CATEGORY               category of your post. Ex: eric, haanhduclinh
-d, --date=DATE                  date of this post
-f, --thumb=THUMBNAIL            thumbnail path of your post. Ex: '~/source/eric.jpg'
-u, --url=URL                    post_url
-l, --title=TITLE                post title
-t, --tag=TAG                    tags of your post. Ex: wp_terminal, wordpress
-h, --help                       Prints this help

```

# Example

```
ENV=dev bundle exec ruby script/terminal_post.rb \
-a /home/a161114/Desktop/1.txt \
-c ruby \
-f /home/a161114/Desktop/eric.jpg \
-u wp-terminal \
-l post_wordpress_with_developer_way \
-t wordpress,wp_terminal,ruby
```

Find more run command `ENV=dev bundle exec ruby script/terminal_post.rb --help`

# How to contributor
+ folk this project
+ create pull request
+ please make sure pass all `rubocop` and `rspec`. If you create another function. Please create `RSpec` for this
# Author
haanhduclinh@yahoo.com