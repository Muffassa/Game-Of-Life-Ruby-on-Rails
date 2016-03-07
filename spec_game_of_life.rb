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

      subject.cell_grid.each do |row|
        row.is_a?(Array).should be_truthy
        row.each do |column|
          column.is_a?(Cell).should be_truthy
        end
      end
    end
  end

  context "Cell" do
    subject {Cell.new}

    it "should create new cell object" do
      subject.is_a?(Cell).should be_truthy
    end

    it "should respond to proper methods" do
      subject.should respond_to(:alive)
      subject.should respond_to(:x)
      subject.should respond_to(:y)
    end

    it "should initialize be properly" do
      subject.alive.should be_falsey
      subject.x.should == 0
      subject.y.should == 0
    end
  end

end
