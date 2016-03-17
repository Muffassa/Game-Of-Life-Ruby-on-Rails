require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window
  def initialize(height = 800, width = 600)
    @height = height
    @width = width
    super height, width, false
    self.caption = "Game of Life"

    #Color

    @background_color = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff121212)
    @dead_color = Gosu::Color.new(0xffededed)
    #Game settings
    @rows = height / 10
    @cols = width / 10

    @col_width = width / @cols
    @row_height = height / @rows

    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
    @game.world.randomly_populate

  end

  def update
    @game.tick!
  end

  def draw
    #White backgound
    draw_quad(0,0, @background_color,
    width, 0, @background_color,
    width, height,@background_color,
    0, height, @background_color)

    #Draw cells
    @game.world.cells.each do |cell|
      if cell.alive?
        draw_cell(cell , @alive_color)
      else
        draw_cell(cell , @dead_color)
      end
    end
  end

  def draw_cell(cell, color)
    draw_quad(cell.x * @col_width, cell.y * @row_height, color,
              cell.x * @col_width + (@col_width - 1), cell.y * @row_height, color,
              cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), color,
              cell.x * @col_width, cell.y * @row_height + (@row_height - 1), color)
  end

  def needs_cursor?; true end;
end

GameOfLifeWindow.new.show
