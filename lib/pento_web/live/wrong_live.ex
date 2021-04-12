defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        time: time(),
        message: "Guess a number."
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
    <%= @message %>
    It's <%= @time %>
    <%= for n <- 1..10 do %>
      <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect data
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    time = time()

    {
      :noreply,
      assign(
        socket,
        message: message,
        time: time,
        score: score
      )
    }
  end
end
