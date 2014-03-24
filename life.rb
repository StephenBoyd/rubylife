#!/bin/env ruby
# encoding: utf-8

# Conway's Game of Life by Stephen Boyd
$generation = 0
$width = 60
$height = 30
$grid1 = Array.new($width+1).map!{Array.new($height+1, false)}
$grid2 = Array.new($width+1).map!{Array.new($height+1, false)}

def init
  ($width).times do |x|
    ($height).times do |y|
      $grid1[x][y] = (rand(2) == 1 ? true : false)
    end
  end
end

init

def print_grid (grid)
  buffer = "\033[42m" #ANSI code for green color
  40.times {buffer << "\n"}
  buffer << "generation: #{$generation} \n"
  $height.times do |y|
    $width.times do |x|
      buffer << (grid[x][y] == true ? "█" : " ")
    end
    buffer << "\n"
  end
  puts buffer << "\033[0m"
end

def generate (source, target)
  $height.times do |y|
    $width.times do |x|
      live_neighbors = 0
      live_neighbors += 1 if source[x-1][y-1] == true
      live_neighbors += 1 if source[x][y-1] == true
      live_neighbors += 1 if source[x+1][y-1] == true
      live_neighbors += 1 if source[x-1][y] == true
      live_neighbors += 1 if source[x+1][y] == true
      live_neighbors += 1 if source[x-1][y+1] == true
      live_neighbors += 1 if source[x][y+1] == true
      live_neighbors += 1 if source[x+1][y+1] == true
      target[x][y] = false
      if source[x][y] == true then
        target[x][y]= true if (live_neighbors == 2 || live_neighbors == 3)
      else
        target[x][y]= true if live_neighbors == 3
      end
    end
  end
  $generation += 1
end

def iterate
  if $generation % 2 == 0 then
    generate $grid1, $grid2
  else
    generate $grid2, $grid1
  end
end


print_grid $grid1

100.times do
  iterate
end

print_grid $grid2

