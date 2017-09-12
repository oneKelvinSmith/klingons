# Klingons

Klingons as a service is an application to summon Klingons. It is also a front for learning how to deploy elixir applications with Docker and Distillery to AWS...


To start the server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
