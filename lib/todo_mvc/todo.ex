defmodule TodoMVC.Todo do
  @enforce_keys [:id, :text, :state]
  defstruct [:id, :text, :state, :editing]

  def new(text) do
    %__MODULE__{id: UUID.uuid4(), text: text, state: "active"}
  end
end
