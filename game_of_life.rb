class Game
  attr_accessor :world, :seeds
  def initialize(world = World.new, seeds = [])
    @world = world
    @seeds = seeds

    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end

  def tick!
    next_round_live_cells = []
    next_round_died_cells = []

    world.cells.each do |cell|
      #Rule 1
      if cell.alive? and world.live_neighbours_around_cell(cell).count < 2
        next_round_died_cells << cell
      end

      #Rule 2
      if cell.alive? and ([2,3].include? world.live_neighbours_around_cell(cell).count)
        next_round_live_cells << cell
      end

      #Rule 3
      if cell.alive? and world.live_neighbours_around_cell(cell).count > 3
        next_round_died_cells << cell
      end

      #Rule 4
      if cell.dead? and world.live_neighbours_around_cell(cell).count == 3
        next_round_live_cells << cell
      end
    end

    next_round_died_cells.each do |cell|
      cell.die!
    end

    next_round_live_cells.each do |cell|
      cell.revive!
    end

  end
end

class World
  attr_accessor :rows, :columns, :cell_grid, :cells, :randomly_populate
  def initialize(rows = 3, columns = 3)
    @rows = rows
    @columns = columns
    @cells = []
    #[[Cell.new, Cell.new, Cell.new],
    #[Cell.new, Cell.new, Cell.new],
    #[Cell.new, Cell.new, Cell.new]],

    @cell_grid = Array.new(rows) do |row|
                Array.new(columns) do |cols|
                  cell = Cell.new(cols, row)
                  cells << cell
                  cell
              end
            end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []

    #neighbours to the North
    if cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end
    #neighbours on the East
    if cell.x < (columns - 1)
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    #neighbours on the South
    if cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end
    #neighbours on the West
    if cell.x > 0
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    #neighbours on the North-West
    if cell.x > 0 and cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    #neighbours on the North-East
    if cell.x < (columns - 1) and cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    #neighbours on the South - East
    if cell.x < (columns - 1) and cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.x > 0 and cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    live_neighbours
  end

  def live_cells
    cells.select {|cell| cell.alive}
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end
end

class Cell
  attr_accessor :alive, :x, :y, :die, :revive, :dead

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @alive = false
  end

  def alive?; alive; end
  def dead?; !alive; end

  def die!
    @alive = false
  end

  def revive!
    @alive = true
  end
end
