import Config

case Mix.env() do
  :dev -> config(:gen_chatting_dynamic, node_env: :dev)
end
