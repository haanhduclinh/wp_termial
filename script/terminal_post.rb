require './lib/wp_terminal'
require 'pry'

wp_terminal = WpTerminal::Core.new
response = wp_terminal.run!

if response[:result]
  puts 'Done | Post created'
else
  puts 'Failed | #{response[:body]}'
end
