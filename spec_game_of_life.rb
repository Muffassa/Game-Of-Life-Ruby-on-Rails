#test file

require 'rspec'
require_relative "game_of_life.rb"

describe "Game of life" do
  context "World" do
    subject { World.new }
    it 'should create new world object' do
      subject.is_a?(World).should be_truthy
    end

    it "should respone the proper methods" do
      subject.should respond_to(:rows)
      subject.should respond_to(:columns)
      subject.should respond_to(:cell_grid)
    end

    it "should create proper cell grid on initialization" do
      subject.cell_grid.is_a?(Array).should be_truthy
    end
  end

end
