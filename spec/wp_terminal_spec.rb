require 'spec_helper'
require './lib/wp_terminal'
require 'pry'

RSpec.describe WpTerminal::Core do
  describe 'initialize' do
    it 'should exist host config' do
      %w(WP_HOST WP_USER WP_PASS ENV WP_AUTHOR_ID).each do |env_name|
        expect(ENV[env_name]).to be_a_kind_of String
      end
    end

    it 'should contain create instance' do
      expect(@wp).to be_truthy
    end

    before do
      @wp = WpTerminal::Core.new
    end
  end

  describe 'post' do
    let(:title) { 'This is test title' }
    let(:post) { 'Hello world' }

    it 'post successful' do
      @wp.submit_post(
        title: title,
        post: post
      )
    end

    before do
      @wp = WpTerminal::Core.new
    end
  end
end
