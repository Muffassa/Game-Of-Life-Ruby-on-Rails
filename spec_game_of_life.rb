#test file

require 'rspec'
require_relative "game_of_life.rb"

describe "Game of life" do
  context "World" do
    subject { World.new }
    it 'should create new world object' do
      subject.is_a?(World).should be_true
    end
  end

end
