defmodule GenChattingDynamic.SimpleCache do
  use GenServer

  def start_link(_init_arg) do
    GenServer.start_link(__MODULE__,[],name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    :ets.new(:chatting_room, [:set, :public, :named_table])
    {:ok, init_arg}
  end

  def get(room_name) do
    :ets.match(:chatting_room, {room_name, :"$1"})
  end

  def set(room_name, client_list) do
    :ets.insert(:chatting_room, {room_name, [self() | client_list]})
  end

end
