defmodule TodoMVCWeb.MainLive do
  use Phoenix.LiveView

  alias TodoMVC.Todo

  def render(assigns) do
    Phoenix.View.render(TodoMVCWeb.MainView, "index.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, assign(socket, todos: [], filter: "all")}
  end

  # We do not want to add a tdo if the text is empty
  def handle_event("add-todo", %{"text" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("add-todo", %{"text" => text}, socket) do
    (todos(socket) ++ [Todo.new(text)])
    |> handle_response(socket)
  end

  def handle_event("destroy", %{"todo-id" => id}, socket) do
    todos(socket)
    |> Enum.reject(fn t -> t.id == id end)
    |> handle_response(socket)
  end

  def handle_event("toggle", %{"todo-id" => id}, socket) do
    toggle = fn
      %Todo{id: ^id} = todo -> Todo.toggle(todo)
      todo -> todo
    end

    todos(socket)
    |> Enum.map(toggle)
    |> handle_response(socket)
  end

  def handle_event("toggle-all", %{"checked" => "false"}, socket) do
    todos(socket)
    |> Enum.map(&Todo.complete/1)
    |> handle_response(socket)
  end

  def handle_event("toggle-all", _params, socket) do
    todos(socket)
    |> Enum.map(&Todo.activate/1)
    |> handle_response(socket)
  end

  def handle_event("clear-completed", _params, socket) do
    todos(socket)
    |> Enum.reject(fn t -> t.state == "completed" end)
    |> handle_response(socket)
  end

  def handle_event("edit", %{"todo-id" => id}, socket) do
    toggle_editing = fn
      %Todo{id: ^id} = todo -> %{todo | editing: true}
      todo -> todo
    end

    todos(socket)
    |> Enum.map(toggle_editing)
    |> handle_response(socket)
  end

  def handle_event("change", %{"title" => text}, socket) do
    update_text = fn
      %Todo{editing: true} = todo -> %{todo | text: text}
      todo -> todo
    end

    todos(socket)
    |> Enum.map(update_text)
    |> handle_response(socket)
  end

  def handle_event("stop-editing", %{"todo-id" => id}, socket) do
    toggle_editing = fn
      %Todo{id: ^id} = todo -> %{todo | editing: false}
      todo -> todo
    end

    todos(socket)
    |> Enum.map(toggle_editing)
    |> handle_response(socket)
  end

  def handle_params(%{"filter" => filter}, _uri, socket) do
    {:noreply, assign(socket, filter: filter)}
  end

  def handle_params(_params, _uri, socket),
    do: {:noreply, socket}

  defp handle_response(todos, socket),
    do: {:noreply, assign(socket, todos: todos)}

  defp todos(socket) do
    socket.assigns[:todos]
  end
end
