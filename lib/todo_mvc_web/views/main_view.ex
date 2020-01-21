defmodule TodoMVCWeb.MainView do
  use TodoMVCWeb, :view
  alias TodoMVC.Todo

  def todo_classes(%Todo{state: "completed"}), do: "completed"
  def todo_classes(_), do: ""
end
