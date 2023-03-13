let root = ReactDOM.querySelector("#root")

switch root {
| Some(root) =>
  root
  ->ReactDOM.Client.createRoot
  ->ReactDOM.Client.Root.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>,
  )
| None => Js.Exn.raiseError("Not found root tag")
}