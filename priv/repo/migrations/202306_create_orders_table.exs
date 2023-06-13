defmodule TableCheckHw.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :restaurant_name, :string
      add :food_name,       :string
      add :first_name,      :string
      add :food_cost,       :float

      timestamps()
    end

    create index(:orders, [:restaurant_name])
  end
end
