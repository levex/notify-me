defmodule NotifyMeWeb.PageController do
  use NotifyMeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create_new_id(conn, _params) do
    json conn, %{status: :ok, uuid: UUID.uuid4()}
  end

  def send_notification(conn, %{"uuid" => uuid}) do
    case UUID.info(uuid) do
      {:ok, _} -> json conn, %{status: :ok, uuid: uuid}
      _ -> json conn, %{status: :error_bad_uuid}
    end
  end
end
