# wp_terminal
Post to your wordpress from Terminal for Ruby developer
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
+ run command `ENV=dev ruby script/terminal_post.rb`

Find more run command `ENV=dev ruby script/terminal_post.rb --help`

# How to contributor
+ folk this project
+ create pull request
+ please make sure pass all `rubocop` and `rspec`. If you create another function. Please create `RSpec` for this
# Contact Author
mail to haanhduclinh@yahoo.com