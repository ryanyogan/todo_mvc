defmodule TodoMVC.Todo do
  @todo __MODULE__
  @enforce_keys [:id, :text, :state]
  defstruct [:id, :text, :state, :editing]

  def new(text) do
    %@todo{id: UUID.uuid4(), text: text, state: "active"}
  end

  def toggle(%@todo{state: "active"} = todo), do: complete(todo)
  def toggle(%@todo{state: "completed"} = todo), do: activate(todo)

  def complete(todo), do: %{todo | state: "completed"}
  def activate(todo), do: %{todo | state: "active"}
end
