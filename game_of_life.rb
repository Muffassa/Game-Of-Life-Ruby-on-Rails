class Game
  attr_accessor :world, :seeds
  def initialize(world = World.new, seeds = [])
    @world = world
    @seeds = seeds

    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end
end

class World
  attr_accessor :rows, :columns, :cell_grid
  def initialize(rows = 3, columns = 3)
    @rows = rows
    @columns = columns

    @cell_grid = Array.new(3) do |row|
                Array.new(3) do |columns|
                  Cell.new(columns, row)
              end
            end
  end
end

class Cell
  attr_accessor :alive, :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @alive = false
  end

  def alive?
    alive
  end
end
