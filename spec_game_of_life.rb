#test file

require 'rspec'
require_relative "game_of_life.rb"

describe "Game of life" do

!let(:world) {World.new}

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
      subject.should respond_to(:alive?)
    end

    it "should initialize be properly" do
      subject.alive.should be_falsey
      subject.x.should == 0
      subject.y.should == 0
    end
  end

  context "Game" do
    subject {Game.new}
    it "should create new game object" do
      subject.is_a?(Game).should be_truthy
    end

    it "should respond to proper methods" do
      subject.should respond_to(:world)
      subject.should respond_to(:seeds)
    end

    it "should initialize properly" do
      subject.world.is_a?(World).should be_truthy
      subject.seeds.is_a?(Array).should be_truthy
      subject.seeds.each do |cell|
        cell.is_a?(Cell).should be_truthy
      end
    end

    it "should plant seeds properly" do
      game = Game.new(world, [[1, 2],[0,2]])
      world.cell_grid[1][2].should be_alive
      world.cell_grid[0][2].should be_alive
    end
  end
  context "Rules" do

    let!(:game) {Game.new}
    context "Rule: Any live cell with fewer than two live
    neighbours dies, as if caused by under-population." do

        it "should kill cell with 1 live neightbour" do

        end
    end

  end

end
