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



// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", #(10,10))
}

// MODEL -----------------------------------------------------------------------


type Model {
  Model(todos:dict.Dict(Int,String),last_todo:Int,current_input:String)
}

fn init(size:#(Int,Int))-> #(Model,effect.Effect(Msg)) {
  #(Model(dict.new(),0,""),effect.none())
}

// UPDATE ----------------------------------------------------------------------

pub opaque type Msg {
  AddTodo()
  RemoveTodo(Int)
  UpdateInput(String)
}

fn update(model: Model, msg: Msg) -> #(Model,effect.Effect(Msg)) {
  case msg {
    AddTodo() -> {
    #(Model(todos:dict.insert(model.todos,model.last_todo,model.current_input),last_todo:model.last_todo+1,current_input:""),effect.none())
    }
    RemoveTodo(index) -> {
      #(Model(..model,todos:dict.delete(model.todos,index),last_todo:model.last_todo),effect.none())
    }
    UpdateInput(input) -> {
      #(Model(..model,current_input:input),effect.none())
    }
  }
}

// VIEW ------------------------------------------------------------------------
fn view(model: Model) -> element.Element(Msg) {
  html.div([],[
    html.h2([],[html.text("Enter a todo")]),
    html.div([],[
      html.input([attribute.value(model.current_input),event.on_input(UpdateInput)]),
      html.button([event.on_click(AddTodo)],[html.text("Add todo")])
    ]),
    html.div([],
      dict.to_list(model.todos) |> list.map(todo_view(_))
    )
  ])
}

fn todo_view(todo_value:#(Int,String)) {
  html.div([attribute.class("flex-row gap-5")],[
    html.p([],[html.text(todo_value.1)]),
    html.button([event.on_click(RemoveTodo(todo_value.0))],[html.text("remove todo")])
  ])
}
