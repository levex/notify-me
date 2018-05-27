defmodule NotifyMe.Computer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "computers" do
    field :last, :string
    field :name, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(computer, attrs) do
    computer
    |> cast(attrs, [:name, :uuid, :last])
    |> validate_required([:name, :uuid, :last])
  end
end
