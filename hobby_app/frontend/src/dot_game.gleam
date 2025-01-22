import gleam/string
import gleam/string_tree
import gleam/list
import lustre/effect
import gleam/dict
import lustre
import gleam/int
import lustre/element
import lustre/attribute
import gleam/io
import lustre/element/html
import lustre/event
import grid



// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", #(10,10))
}

// MODEL -----------------------------------------------------------------------


type Model {
  Model(grid:grid.Grid,color:grid.TileColor)
}

fn init(size:#(Int,Int))-> #(Model,effect.Effect(Msg)) {
  #(Model(grid.new_grid(size),grid.Blue),effect.none())
}

// UPDATE ----------------------------------------------------------------------

pub opaque type Msg {
  ChangeColor(tile:grid.Tile)
  ChangePallet(grid.TileColor)
}

fn update(model: Model, msg: Msg) -> #(Model,effect.Effect(Msg)) {
  case msg {
    ChangeColor(tile) -> {
      let new_tile = grid.Tile(..tile,color:model.color)
      #(Model(..model,grid:grid.set_tile(model.grid,new_tile)),effect.none())
    }
    ChangePallet(color) -> {
      #(Model(..model,color:color),effect.none())
    }
  }
}

// VIEW ------------------------------------------------------------------------
fn view(model: Model) -> element.Element(Msg) {
  html.div([],[
    pallet_view(),
    grid_view(model.grid)
  ])
}

fn pallet_view() {
  html.div([attribute.class("col")],[
    html.div([
      attribute.style([#("background-color","blue")]),
      event.on_click(ChangePallet(grid.Blue))
    ],[]),
    html.div([
      attribute.style([#("background-color","white")]),
      event.on_click(ChangePallet(grid.Clear))
    ],[]),
    html.div([
      attribute.style([#("background-color","green")]),
      event.on_click(ChangePallet(grid.Green))
    ],[]),
    html.div([
      attribute.style([#("background-color","red")]),
      event.on_click(ChangePallet(grid.Red))
    ],[]),
    html.div([
      attribute.style([#("background-color","yellow")]),
      event.on_click(ChangePallet(grid.Yellow))
    ],[]),
  ])
}

fn grid_view(grid:grid.Grid) {
  html.div([],
    list.range(0,grid.size.1)
    |> list.map(fn(y) {
      html.div([attribute.class("flex-row")],list.range(0,grid.size.0)
        |> list.map(fn(x) {
          let cords = #(x,y)
          io.debug(grid)
            case grid.get_tile(grid,cords) {
              Ok(color) ->  tile_view(color)
              Error(_) ->  { io.debug(cords)  panic as "we should never be out of scope in this view function" }
            }
        }))
    })
  )
}

fn tile_view(tile:grid.Tile) -> element.Element(Msg){
  let x_string = int.to_string(tile.cords.0)
  let y_string = int.to_string(tile.cords.1)
  let cords_string = string_tree.new()
    |> string_tree.append("(")
    |> string_tree.append(x_string)
    |> string_tree.append(",")
    |> string_tree.append(y_string)
    |> string_tree.append(")")
    |> string_tree.to_string

  html.div([
    attribute.style([#("background-color",color_to_string(tile.color))]),
    event.on_click(ChangeColor(tile))
  ],[html.text(cords_string)])
}

pub fn color_to_string(color:grid.TileColor) {
  case color {
    grid.Blue -> "blue"
    grid.Clear -> "white"
    grid.Green -> "green"
    grid.Red -> "red"
    grid.Yellow -> "yellow"
  }
}


//        list.range(0,model.size.1)
// |> list.map(fn() { html.div([],[]) })
