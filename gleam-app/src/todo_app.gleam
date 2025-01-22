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
  Model(todos:dict.Dict(Int,String))
}

fn init(size:#(Int,Int))-> #(Model,effect.Effect(Msg)) {
  #(Model(grid.new_grid(size),grid.Blue),effect.none())
}

// UPDATE ----------------------------------------------------------------------

pub opaque type Msg {
  AddTodo(todo_name:String)
  RemoveTodo(Int)
}

fn update(model: Model, msg: Msg) -> #(Model,effect.Effect(Msg)) {
  case msg {
    AddTodo(_) -> todo
    RemoveTodo(_) -> todo
  }
}

// VIEW ------------------------------------------------------------------------
fn view(model: Model) -> element.Element(Msg) {
  html.div([],[
  ])
}
