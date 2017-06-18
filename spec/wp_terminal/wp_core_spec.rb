require 'spec_helper'
require './lib/wp_terminal/wp_core'

RSpec.describe WpTerminal::WpCore do
  describe 'initialize' do
    before do
      WpCore.new
    end
  end
end
