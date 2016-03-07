class World
  attr_accessor :rows, :columns, :cell_grid
  def initialize(rows = 3, columns = 3)
    @rows = rows
    @columns = columns

    @cell_grid = Array.new(3) do |row|
                Array.new(3) do |columns|
                  Cell.new
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
end
