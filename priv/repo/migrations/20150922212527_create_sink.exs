defmodule SslBench.Repo.Migrations.CreateSink do
  use Ecto.Migration

  def change do
    create table(:sinks, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :mode, :string
      add :port, :integer

      timestamps
    end

  end
end
