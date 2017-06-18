source 'https://rubygems.org'
ruby '2.3.0'
gem 'activesupport'
gem 'auto_html'
gem 'config', '1.4.0'
gem 'rubypress'
gem 'stringex', '~> 2.7', '>= 2.7.1'

group :test do
  %w[rspec rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib, git: "git://github.com/rspec/#{lib}.git", branch: 'master'
  end
end

group :development do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'rubocop', '~> 0.47.1', require: false
end
