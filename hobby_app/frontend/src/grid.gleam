import gleam/io
import gleam/list
import gleam/dict

pub type Grid {
  Grid(tile:dict.Dict(#(Int,Int),Tile),size:#(Int,Int))
}

pub type TileColor {
  Clear
  Red
  Green
  Blue
  Yellow
}


pub type Tile {
  Tile(cords:#(Int,Int),color:TileColor)
}

//its like R place with timed tiles

pub fn new_grid(wh: #(Int,Int)) {
  let tiles = list.range(0,wh.0)
  |> list.map(fn(y) {
    list.range(0,wh.0) |>
    list.map(fn(x) {
      let cords = #(x,y)
      Tile(cords,Clear)
    })
  })
  |> list.flatten // could be slow
  |> list.fold(dict.new(), fn(acc,node) {
    dict.insert(acc,node.cords,node)
  })

  Grid(tiles,wh)
}

pub fn get_tile(grid:Grid,cords:#(Int,Int)) {
  dict.get(grid.tile,cords)
}

pub fn set_tile(grid:Grid,tile:Tile) {
  Grid(..grid,tile:dict.insert(grid.tile,tile.cords,tile))
}
