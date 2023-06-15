# TableCheck Data Operations (Elixir Developer) - Take Home Project

Take a look at the dataset located in `/data/data.csv`. Your goal is to interpret it and create an API that can answer the following questions:
  - [x] How many customers visited the "Restaurant at the end of the universe"?
    - [GET `/v1/orders/restaurants/the-restaurant-at-the-end-of-the-universe/customers/count`](/docs/api.md#count-customers-by-restaurant-name)
    - Answer: 37230
  - [x] How much money did the "Restaurant at the end of the universe" make?
    - [GET `/v1/orders/restaurants/the-restaurant-at-the-end-of-the-universe/revenue`](/docs/api.md#get-revenue-by-restaurant-name)
    - Answer: 186944.0
  - [x] What was the most popular dish at each restaurant?
    - [GET `/v1/orders/restaurants/dishes/top`](/docs/api.md#get-the-most-popular-dish-at-restaurant)
    - Answer:
```
[
    {
        "count": 1196,
        "food_name": "juice",
        "restaurant_name": "johnnys-cashew-stand"
    },
    {
        "count": 1185,
        "food_name": "honey",
        "restaurant_name": "bean-juice-stand"
    },
    {
        "count": 1158,
        "food_name": "cheese",
        "restaurant_name": "the-restaurant-at-the-end-of-the-universe"
    },
    {
        "count": 1151,
        "food_name": "beans",
        "restaurant_name": "the-ice-cream-parlor"
    }
]
```
  - [x] What was the most profitable dish at each restaurant?
    - [GET `/v1/orders/restaurants/dishes/profit/top`](/docs/api.md#get-the-most-profitable-dish-at-each-restaurant)
    - Answer:
```
[
    {
        "food_name": "juice",
        "restaurant_name": "johnnys-cashew-stand",
        "sum": 5989.0
    },
    {
        "food_name": "honey",
        "restaurant_name": "bean-juice-stand",
        "sum": 5945.5
    },
    {
        "food_name": "cheese",
        "restaurant_name": "the-restaurant-at-the-end-of-the-universe",
        "sum": 5861.5
    },
    {
        "food_name": "coffee",
        "restaurant_name": "the-ice-cream-parlor",
        "sum": 5789.5
    }
]
```
  - [x] Who visited each store the most?
    - [GET `/v1/orders/restaurants/customers/top`](/docs/api.md#get-the-top-customer-at-each-restaurant)
    - Answer:
```
[
    {
        "first_name": "Michael",
        "restaurant_name": "the-ice-cream-parlor",
        "visit_count": 915
    },
    {
        "first_name": "Michael",
        "restaurant_name": "bean-juice-stand",
        "visit_count": 855
    },
    {
        "first_name": "Michael",
        "restaurant_name": "the-restaurant-at-the-end-of-the-universe",
        "visit_count": 849
    },
    {
        "first_name": "Michael",
        "restaurant_name": "johnnys-cashew-stand",
        "visit_count": 843
    }
]
```
  - [x] Who visited the most stores?
    - [GET `/v1/orders/customers/top`](/docs/api.md#get-the-top-customer)
    - Answer:
```
{
    "first_name": "Michael",
    "visit_count": 3462
}
```

## Tasks

- [x] Ingest the data into your database of choice.
- [x] Create an API.
- [x] Create API documentation that has explicit examples on how to answer the questions listed above.
- [x] Document your solution as a whole.
  - Please check [docs/solution.md](/docs/solution.md)

Please document your solution, and provide answers to the following questions at the end as well.
* How would you build this differently if the data was being streamed from Kafka?
* How would you improve the deployment of this system?


## Questions
### What library should I use?
There is no limit on the choice of library or other semantics. Use what you are familiar with and what you would recommend.

### How should I ingest the data?
You can use any method you like to ingest the data. You can use a script, a tool, or even a direct database import if your chosen database supports that. The only requirement is that the data is eventually stored in some kind of database.

## Prerequisit

Make sure you have the following installed on your machine:

* PostgreSQL
* asdf
* docker(optional)

## Setup

1. clone the project `git clone git@github.com:ColaCheng/table_check_hw.git`
2. `cd` into project directory
3. run `asdf install` to install Erlang and Elixir
4. run `mix do deps.get, compile` to install required dependencies and compile it
5. run `docker-compose up -d` to create local PostgreSQL database(optional, if you prefer to run PostgreSQL in another way)
6. run `mix ecto.setup` to create development db, run migrations, and insert seed data from [/data/data.csv](/data/data.csv)

> If you want to recreate the DB environment, run: `mix ecto.reset`

## Running Service

### mix run

In terminal, run `iex -S mix run`.
Now you should be getting response from `curl -i http://localhost:8080/health`.

### release package run

This is the normal way to run the Elixir application in the production environment.

```
$ MIX_ENV=prod mix release
Release created at _build/prod/rel/table_check_hw

    # To start your system
    _build/prod/rel/table_check_hw/bin/table_check_hw start

Once the release is running:

    # To connect to it remotely
    _build/prod/rel/table_check_hw/bin/table_check_hw remote

    # To stop it gracefully (you may also send SIGINT/SIGTERM)
    _build/prod/rel/table_check_hw/bin/table_check_hw stop

To list all commands:

    _build/prod/rel/table_check_hw/bin/table_check_hw

$ DATABASE_URL="postgresql://postgres:postgres@localhost:5432/table_check_hw_dev" ./_build/prod/rel/table_check_hw/bin/table_check_hw start
```

### use docker

1. Build the docker image

        docker build -t table_check_hw:latest .

2. Run the docker container

        docker run \
        -e HTTP_PORT=8080 \
        -e DATABASE_URL="postgresql://{DB_USERNAME}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}" \
        --publish 8080:8080 \
        table_check_hw:latest

3. Validate that it works by querying the `/health` endpoint

        curl -i http://localhost:8080/health

    This should return 204.

## Running Test

1. assuming you have gone through all of [Setup Section](#setup)
2. run `mix ecto.reset`
3. run `mix test`

## Testing HTTP API

Please use your familiar tool to access the API according to the [API documentation](/docs/api.md).
Or you can import the Postman config file from [table_check_hw.postman_collection.json](/http/postman/table_check_hw.postman_collection.json) then you can try to play with that.

> Note: run the server first!

## Documentation

Please check the documentation in `docs` folder.

- [API documentation](/docs/api.md)
- [Solution documentation](/docs/solution.md)
