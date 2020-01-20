defmodule TodoMVCWeb.MainLive do
  use Phoenix.LiveView

  alias TodoMVC.Todo

  def render(assigns) do
    Phoenix.View.render(TodoMVCWeb.MainView, "index.html", assigns)
  end

  def mount(_params, socket) do
    {:ok, assign(socket, todos: [Todo.new("First Todo")])}
  end

  # We do not want to add a tdo if the text is empty
  def handle_event("add-todo", %{"text" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("add-todo", %{"text" => text}, socket) do
    todos = socket.assigns[:todos] ++ [Todo.new(text)]

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("destroy", %{"todo-id" => id}, socket) do
    todos =
      socket.assigns[:todos]
      |> Enum.reject(fn t -> t.id == id end)

    {:noreply, assign(socket, todos: todos)}
  end
end
