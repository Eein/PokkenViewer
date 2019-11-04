defmodule PokkenViewerWeb.PokkenControllerLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h1>I'm a controller</h1>
      <div>Y: <%= @button_0 %></div>
      <div>B: <%= @button_1 %></div>
      <div>A: <%= @button_2 %></div>
      <div>X: <%= @button_3 %></div>
      <div>L: <%= @button_4 %></div>
      <div>R: <%= @button_5 %></div>
      <div>ZL: <%= @button_6 %></div>
      <div>ZR: <%= @button_7 %></div>
      <div>Select: <%= @button_8 %></div>
      <div>Start: <%= @button_9 %></div>
      <div>x-axis: <%= @axis_4 %></div>
      <div>y-axis: <%= @axis_5 %></div>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, joystick} = Joystick.start_link(0, self())
    # if connected?(socket), do: :timer.send_interval(100, self())
    {:ok, assign(socket,
      button_0: 0, # y
      button_1: 0, # b
      button_2: 0, # a
      button_3: 0, # x
      button_4: 0, # L
      button_5: 0, # R
      button_6: 0, # ZL
      button_7: 0, # ZR
      button_8: 0, # select
      button_9: 0, # start

      axis_4: 0, # x axis
      axis_5: 0 # y axis
    )}
  end

  def handle_info({:joystick, event}, socket) do

    name = case event.type do
      :button -> "button_" <> to_string(event.number)
      :axis-> "axis_" <> to_string(event.number)
      :init -> "init_" <> to_string(event.number)
    end

    if event.type === :init do
      {:noreply, socket}
    else
      {:noreply, assign(socket, String.to_atom(name), event.value)}
    end
  end

end
