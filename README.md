## rescript with react

TodoList practice using rescript and react

### css module

external 키워드 사용하여 css 적용

```rescript
@module external styles: {..} = "./Todo.module.css"

@react.component
let make = () => {
  <div className={styles["item"]} />
}
```

### useState

```rescript
let (todos, setTodos) = React.useState(_ => [])
```
