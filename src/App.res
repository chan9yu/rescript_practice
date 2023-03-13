%%raw("import './styles/main.css'")

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"todo"} => <Todo />
  | _ => <Todo />
  }
}