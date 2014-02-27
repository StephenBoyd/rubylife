$generation = 0
$width = 60
$height = 30

$grid1 = Hash.new
$grid2 = Hash.new
$width.times do |x|
  $height.times do |y|
    $grid1[[x, y]]= [true, false].sample
  end
end

def print_grid (grid)
  buffer = ""
  40.times {buffer << "\n"}
  buffer << "generation: #{$generation} \n"
  $height.times do |y|
    $width.times do |x|
      buffer << (grid[[x, y]] == true ? "X" : ".")
    end
    buffer << "\n"
  end
  puts buffer
end

def generate (source, target)
  $height.times do |y|
    $width.times do |x|
      live_neighbors = 0
      live_neighbors += 1 if source[[(x-1),(y-1)]] == true
      live_neighbors += 1 if source[[(x),(y-1)]] == true
      live_neighbors += 1 if source[[(x+1),(y-1)]] == true
      live_neighbors += 1 if source[[(x-1),(y)]] == true
      live_neighbors += 1 if source[[(x+1),(y)]] == true
      live_neighbors += 1 if source[[(x-1),(y+1)]] == true
      live_neighbors += 1 if source[[(x),(y+1)]] == true
      live_neighbors += 1 if source[[(x+1),(y+1)]] == true
      target[[x, y]] = false
      if source[[x, y]] == true then
        target[[x, y]]= true if (live_neighbors == 2 || live_neighbors == 3)
      else
        target[[x, y]]= true if live_neighbors == 3
      end
    end
  end
  $generation += 1
end

def iterate
  if $generation % 2 == 0 then
    generate $grid1, $grid2
    print_grid $grid2
  else
    generate $grid2, $grid1
    print_grid $grid1
  end
end

print_grid $grid1

while true do
  iterate
  sleep 0.2
end
