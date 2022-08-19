defmodule GenChattingDynamic do
  use GenServer

  def start_link(init_arg) do
    room_name = init_arg[:room_name]
    GenServer.start_link(__MODULE__, [], name: room_name)
  end

  def send({room_name, message}) do
    GenServer.cast(room_name, {:send, message})
  end

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_call({:connect, client_pid}, _from, state) do
    {:reply, client_pid, Enum.uniq([client_pid | state])}
  end

  @impl true
  def handle_cast({:send, message}, state) do
    Enum.map(state, fn client_pid -> send(client_pid, {:message, message}) end)
    {:noreply, state}
  end
end
