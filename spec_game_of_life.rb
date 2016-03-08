#test file

require_relative "game_of_life.rb"
require 'rspec'

describe "Game of life" do

!let(:world) {World.new}
!let(:cell) {Cell.new(1,1)}
  context "World" do
    subject { World.new }

    it 'should create new world object' do
      subject.is_a?(World).should be_truthy
    end

    it "should respone the proper methods" do
      subject.should respond_to(:rows)
      subject.should respond_to(:columns)
      subject.should respond_to(:cell_grid)
      subject.should respond_to(:live_neighbours_around_cell)
      subject.should respond_to(:cells)
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

    it "should add all cells to cells array" do
      subject.cells.count.should == 9
    end

    it "should detect neightbour on the North" do
      subject.cell_grid[cell.y - 1][cell.x].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the East" do
      subject.cell_grid[cell.y][cell.x + 1].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the South" do
      subject.cell_grid[cell.y + 1][cell.x].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the West" do
      subject.cell_grid[cell.y][cell.x - 1].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the West-North" do
      subject.cell_grid[cell.y - 1][cell.x - 1].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the North-East" do
      subject.cell_grid[cell.y - 1][cell.x + 1].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the South - East" do
      subject.cell_grid[cell.y + 1][cell.x + 1].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end

    it "should detect neightbour on the South - West" do
      subject.cell_grid[cell.y + 1][cell.x - 1].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
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
      subject.should respond_to(:die!)
      subject.should respond_to(:revive!)
    end

    it "should initialize be properly" do
      subject.alive.should be_falsey
      subject.x.should === 0
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
    context "Rule 1: Any live cell with fewer than two live
    neighbours dies, as if caused by under-population." do

        it "should kill cell with 1 live neightbour" do
          game = Game.new(world, [[1,0], [0,1]])
          game.tick!
          world.cell_grid[1][0].should be_dead
          world.cell_grid[0][1].should be_dead
        end

        it "should kill cell with 0 live neighbours" do
          game.world.cell_grid[1][1].alive = true
          game.tick!
          game.world.cell_grid[1][1].should be_dead
        end

        it "should cell alive with two neightbours" do
          game = Game.new(world, [[0,1],[1,1],[2,1]])
          game.tick!
          world.cell_grid[1][1].should be_alive
        end
    end
    context "Rule 2: Any live cell with two or
    three live neighbours lives on to the next generation." do

        it "should live cell with two neightbours" do
          game = Game.new(world, [[1,1],[1,0],[1,2]])
          world.live_neighbours_around_cell(world.cell_grid[1][1]).count.should == 2
          world.live_neighbours_around_cell(world.cell_grid[1][0]).count.should == 1
          game.tick!
          world.cell_grid[1][1].should be_alive
          world.cell_grid[1][0].should be_dead
          world.cell_grid[1][2].should be_dead
        end

        it "should be live cell with three neightbours" do
          game = Game.new(world, [[0,1],[1,1],[2,1],[2,2]])
          game.tick!
          world.cell_grid[0][1].should be_dead
          world.cell_grid[1][1].should be_alive
          world.cell_grid[2][1].should be_alive
          world.cell_grid[2][2].should be_alive
        end
    end
    context "Rule 3: Any live cell with more than three
    live neighbours dies, as if by over-population " do

        it "should be dead with more than three neightbours" do
          game = Game.new(world, [[0,0],[0,1],[0,2],[1,0],[1,1]])
          game.tick!
          world.cell_grid[0][0].should be_alive
          world.cell_grid[0][1].should be_dead
          world.cell_grid[0][2].should be_alive
          world.cell_grid[1][0].should be_alive
          world.cell_grid[1][1].should be_dead
        end
    end

    context "Rule 4: Any dead cell with exactly three live neighbours
    becomes a live cell, as if by reproduction" do
        it "should revive dead cell with 3 neightbours" do
          game = Game.new(world, [[0,1],[1,0],[1,2]])
          world.live_neighbours_around_cell(world.cell_grid[0][1]).count == 1
          game.tick!
          world.cell_grid[1][1].should be_alive
          world.cell_grid[0][1].should be_alive
          world.cell_grid[1][0].should be_dead
          world.cell_grid[1][2].should be_dead
        end
    end
  end

end
