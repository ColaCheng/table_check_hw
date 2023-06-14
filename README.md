# TableCheck Data Operations (Elixir Developer) - Take Home Project

Take a look at the dataset located in `/data/data.csv`. Your goal is to interpret it and create an API that can answer the following questions:
  - [x] How many customers visited the "Restaurant at the end of the universe"?
    - [GET `/v1/orders/restaurants/the-restaurant-at-the-end-of-the-universe/customers/count`](/docs/api.md#count-customers-by-restaurant-name)
  - [x] How much money did the "Restaurant at the end of the universe" make?
    - [GET `/v1/orders/restaurants/the-restaurant-at-the-end-of-the-universe/revenue`](/docs/api.md#get-revenue-by-restaurant-name)
  - [x] What was the most popular dish at each restaurant?
    - [GET `/v1/orders/restaurants/dishes/top`](/docs/api.md#get-the-most-popular-dish-at-restaurant)
  - [x] What was the most profitable dish at each restaurant?
    - [GET `/v1/orders/restaurants/dishes/profit/top`](/docs/api.md#get-the-most-profitable-dish-at-each-restaurant)
  - [x] Who visited each store the most, and who visited the most stores?
    - [GET `/v1/orders/restaurants/customers/top` (Who visited each store the most?)](/docs/api.md#get-the-top-customer-at-each-restaurant)
    - [GET `/v1/orders/customers/top` (Who visited the most stores?)](/docs/api.md#get-the-top-customer)

## Tasks

- [x] Ingest the data into your database of choice.
- [x] Create an API.
- [x] Create API documentation that has explicit examples on how to answer the questions listed above.
- [ ] Document your solution as a whole.

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

1. Clone the project `git clone git@github.com:ColaCheng/table_check_hw.git`
2. `cd` into project directory
3. run `asdf install` to install Erlang and Elixir
4. run `mix deps.get` to install required dependencies
5. run `mix ecto.setup` to create development db, run migrations, and insert seed data
6. run `docker-compose up -d` to create local PostgreSQL database(optional, if you prefer to run PostgreSQL in another way)

> If you want to recreate the DB environment, run: `mix ecto.reset`

## Running Server

In terminal, run `iex -S mix run`.
Now you should be getting response from `curl -i http://localhost:8080/health`.

## Running Test

1. assuming you have gone through all of [Setup Section](#setup)
2. run `MIX_ENV=test mix ecto.reset`
3. run `mix test.watch`

## Documentation

Please check the documentation in `docs` folder.

- [API documentation](/docs/api.md)
