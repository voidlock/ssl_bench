defmodule SslBench.ChangesetView do
  use SslBench.Web, :view

  def render("error.json", %{changeset: changeset}) do
    %{errors: changeset}
  end
end
