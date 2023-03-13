@module external styles: {..} = "./Todo.module.css"

type todo = {
  userId: int,
  id: int,
  title: string,
  completed: bool,
}

external typeTodos: Js.Json.t => array<todo> = "%identity"

let url = "https://jsonplaceholder.typicode.com/users/1/todos"

@react.component
let make = () => {
  let (todos, setTodos) = React.useState(_ => [])

  React.useEffect0(() => {
    let break = ref(false)

    let getTodos = async () => {
      open Fetch
      open Promise

      setTodos(_ => [])

      let todosJson = await fetch(url)->then(Response.json)

      if !break.contents {
        let todos = typeTodos(todosJson)
        setTodos(prev => prev->Js.Array2.concat(todos))
      }
    }

    getTodos()->ignore

    Some(() => break := true)
  })

  let onClickTodo = (_, ~id: int) => {
    setTodos(prev =>
      prev->Js.Array2.map(item => {
        switch item.id == id {
        | true => {...item, completed: !item.completed}
        | false => item
        }
      })
    )
  }

  let onRemoveTodo = (_, ~id: int) => {
    setTodos(prev => prev->Js.Array2.filter(item => item.id !== id))
  }

  <div>
    {todos
    ->Js.Array2.map(todo =>
      <div
        key={Belt.Int.toString(todo.id)}
        className={styles["item"]}
        onClick={e => onClickTodo(e, ~id=todo.id)}>
        <span>
          {switch todo.completed {
          | true => "✅"->React.string
          | false => "❎"->React.string
          }}
        </span>
        <span
          style={ReactDOM.Style.make(
            ~textDecoration=switch todo.completed {
            | true => "line-through"
            | false => "none"
            },
            (),
          )}>
          {todo.title->React.string}
        </span>
        <button onClick={e => onRemoveTodo(e, ~id=todo.id)}> {"삭제"->React.string} </button>
        <hr />
      </div>
    )
    ->React.array}
  </div>
}