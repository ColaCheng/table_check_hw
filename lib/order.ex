defmodule TableCheckHw.Order do
  @moduledoc """
  The order context functionality module
  """

  use TableCheckHw, :context

  alias TableCheckHw.Schema.Order

  @spec insert_all(
          entries_or_query :: [%{required(atom()) => value} | Keyword.t(value)] | Ecto.Query.t(),
          opts :: Keyword.t()
        ) ::
          {non_neg_integer, nil | [term]}
        when value: term() | Ecto.Query.t()
  def insert_all(entries_or_query, opts \\ []) do
    Repo.insert_all(Order, entries_or_query, opts)
  end

  @spec count_customers_by_restaurant_name(restaurant_name :: String.t()) :: integer()
  def count_customers_by_restaurant_name(restaurant_name) do
    from(o in Order,
      where: o.restaurant_name == ^restaurant_name,
      select: count(o.first_name)
    )
    |> Repo.all()
    |> hd()
  end

  @spec get_revenue_by_restaurant_name(name :: String.t()) :: float() | nil
  def get_revenue_by_restaurant_name(restaurant_name) do
    from(o in Order,
      where: o.restaurant_name == ^restaurant_name,
      select: sum(o.food_cost)
    )
    |> Repo.all()
    |> hd()
  end

  @spec get_the_most_popular_dish_at_restaurant() :: [
          %{
            restaurant_name: String.t(),
            food_name: String.t(),
            count: integer()
          }
        ]
  def get_the_most_popular_dish_at_restaurant() do
    sub1 =
      from(o in Order,
        select: %{
          restaurant_name: o.restaurant_name,
          food_name: o.food_name,
          count: count(o.food_name)
        },
        group_by: [o.restaurant_name, o.food_name]
      )

    sub2 =
      from(sub1 in subquery(sub1),
        select: %{
          restaurant_name: sub1.restaurant_name,
          food_name: sub1.food_name,
          count: sub1.count,
          rank:
            over(row_number(), partition_by: sub1.restaurant_name, order_by: [desc: sub1.count])
        }
      )

    from(summary in subquery(sub2),
      select: %{
        restaurant_name: summary.restaurant_name,
        food_name: summary.food_name,
        count: summary.count
      },
      where: summary.rank == 1,
      order_by: [desc: summary.count]
    )
    |> Repo.all()
  end

  @spec get_the_most_profitable_dish_at_restaurant() :: [
          %{
            restaurant_name: String.t(),
            food_name: String.t(),
            sum: float()
          }
        ]
  def get_the_most_profitable_dish_at_restaurant() do
    sub1 =
      from(o in Order,
        select: %{
          restaurant_name: o.restaurant_name,
          food_name: o.food_name,
          sum: sum(o.food_cost)
        },
        group_by: [o.restaurant_name, o.food_name]
      )

    sub2 =
      from(sub1 in subquery(sub1),
        select: %{
          restaurant_name: sub1.restaurant_name,
          food_name: sub1.food_name,
          sum: sub1.sum,
          rank: over(row_number(), partition_by: sub1.restaurant_name, order_by: [desc: sub1.sum])
        }
      )

    from(summary in subquery(sub2),
      select: %{
        restaurant_name: summary.restaurant_name,
        food_name: summary.food_name,
        sum: summary.sum
      },
      where: summary.rank == 1,
      order_by: [desc: summary.sum]
    )
    |> Repo.all()
  end

  @spec get_the_top_customer_at_restaurant() :: %{
          restaurant_name: String.t(),
          first_name: String.t(),
          visit_count: integer()
        }
  def get_the_top_customer_at_restaurant() do
    sub1 =
      from(o in Order,
        select: %{
          restaurant_name: o.restaurant_name,
          first_name: o.first_name,
          visit_count: count(o.first_name)
        },
        group_by: [o.restaurant_name, o.first_name]
      )

    sub2 =
      from(sub1 in subquery(sub1),
        select: %{
          restaurant_name: sub1.restaurant_name,
          first_name: sub1.first_name,
          visit_count: sub1.visit_count,
          rank:
            over(row_number(),
              partition_by: sub1.restaurant_name,
              order_by: [desc: sub1.restaurant_name, desc: sub1.visit_count]
            )
        }
      )

    from(summary in subquery(sub2),
      select: %{
        restaurant_name: summary.restaurant_name,
        first_name: summary.first_name,
        visit_count: summary.visit_count
      },
      where: summary.rank == 1,
      order_by: [desc: summary.visit_count]
    )
    |> Repo.all()
  end

  @spec get_the_top_customer() :: %{
          first_name: String.t(),
          visit_count: integer()
        }
  def get_the_top_customer() do
    sub1 =
      from(o in Order,
        select: %{
          first_name: o.first_name,
          visit_count: count(o.first_name)
        },
        group_by: [o.first_name]
      )

    sub2 =
      from(sub1 in subquery(sub1),
        select: %{
          first_name: sub1.first_name,
          visit_count: sub1.visit_count,
          rank: over(row_number(), order_by: [desc: sub1.visit_count])
        }
      )

    from(summary in subquery(sub2),
      select: %{
        first_name: summary.first_name,
        visit_count: summary.visit_count
      },
      where: summary.rank == 1,
      order_by: [desc: summary.visit_count]
    )
    |> Repo.all()
    |> hd()
  end
end
