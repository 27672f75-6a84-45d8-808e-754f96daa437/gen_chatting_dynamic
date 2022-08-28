defmodule GenChattingDynamic.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def connect(room_name) do
    clients_list = GenChattingDynamic.SimpleCache.get(room_name)
    spec = {GenChattingDynamic, room_name: room_name}
    case DynamicSupervisor.start_child(__MODULE__, spec) do
      {:ok, worker_pid} -> GenServer.call(worker_pid, {:connect, [self() | clients_list]})
      {:error, {_worker_state, worker_pid}} -> GenServer.call(worker_pid, {:connect,[self() | clients_list]})
    end

    GenChattingDynamic.SimpleCache.set(room_name, [self() | clients_list] )
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
