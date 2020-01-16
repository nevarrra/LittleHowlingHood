require "vector2"

function CreateBoundary(x, y, w, h)
  return {edges = vector2.new(x, y), size = vector2.new(w, h)}
    
end
  
  function DrawBoundaries(boundary)
    
    
    for i = 1, #boundary, 1 do
      
      love.graphics.setColor (0.5, 1, 0.1)
      love.graphics.rectangle("fill", boundary[i].edges.x, boundary[i].edges.y, boundary[i].size.x, boundary[i].size.y)
      
    end
    
  end