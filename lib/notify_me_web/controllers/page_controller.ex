defmodule NotifyMeWeb.PageController do
  import Ecto.Query
  use NotifyMeWeb, :controller
  alias NotifyMe.{Computer, Repo}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create_new_id(conn, _params) do
    uuid = UUID.uuid4()
    Repo.insert(%Computer{name: "something", uuid: uuid, last: ""})
    json conn, %{status: :ok, uuid: uuid}
  end

  defp do_notif(uuid, msg) do
    prev = Repo.one(from c in Computer, where: ilike(c.uuid, ^uuid))
    if prev == nil do
      :error
    else
      Repo.delete(prev)
      Repo.insert(%Computer{name: "test", uuid: uuid, last: msg})
      :ok
    end
  end

  defp read_notif(uuid) do
    prev = Repo.one(from c in Computer, where: ilike(c.uuid, ^uuid))
    if prev == nil do
      :error
    else
      #IO.inspect(prev)
      {:ok, prev.last}
    end
  end

  def get_notification(conn, %{"uuid" => uuid}) do
    case UUID.info(uuid) do
      {:ok, _} -> case read_notif(uuid) do
          {:ok, msg} -> json conn, %{status: :ok, msg: msg}
          _ -> json conn, %{status: :error_unknown_uuid}
        end
      _ -> json conn, %{status: :error_bad_uuid}
    end
  end

  def send_notification(conn, %{"msg" => msg, "uuid" => uuid}) do
    case UUID.info(uuid) do
      {:ok, _} -> case do_notif(uuid, msg) do
          :ok -> json conn, %{status: :ok, uuid: uuid, msg: msg}
          _ -> json conn, %{status: :error_unknown_uuid}
        end
      _ -> json conn, %{status: :error_bad_uuid}
    end
  end
end
