defmodule PokkenViewerWeb.PokkenControllerLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
      <div id='controller'>
        <div id='buttons'>
        <div id='y' class="button <%= if @button_0 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='b' class="button <%= if @button_1 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='a' class="button <%= if @button_2 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='x' class="button <%= if @button_3 == 1, do: 'enabled', else: 'disabled' %>"></div>
      </div>
      <div id='triggers'>
        <div id='l' class="trigger <%= if @button_4 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='r' class="trigger <%= if @button_5 == 1, do: 'enabled', else: 'disabled' %>"></div>
      </div>
      <div id='sub-buttons'>
        <div id='select' class="sub-button <%= if @button_8 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='start' class="sub-button <%= if @button_9 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='zl' class="sub-button <%= if @button_6 == 1, do: 'enabled', else: 'disabled' %>"></div>
        <div id='zr' class="sub-button <%= if @button_7 == 1, do: 'enabled', else: 'disabled' %>"></div>
      </div>
      <div id='d-pad-container'>
        <div id='d-pad'>
          <div id='x-axis'>
            <div id='left' class="<%= if @axis_4 < 0, do: 'enabled', else: 'disabled' %>"></div>
            <div id='right' class="<%= if @axis_4 > 0, do: 'enabled', else: 'disabled' %>"></div>
          </div>
          <div id='y-axis'>
            <div id='up' class="<%= if @axis_5 < 0, do: 'enabled', else: 'disabled' %>"></div>
            <div id='down' class="<%= if @axis_5 > 0, do: 'enabled', else: 'disabled' %>"></div>
          </div>
        </div>
      </div>
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
