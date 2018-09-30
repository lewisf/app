defmodule AppWeb.ServerPropertiesView do
  use AppWeb, :view

  @project_version Mix.Project.config[:version]
  # @runtime_version :os.cmd(:"elixir --version | grep Elixir")

  def properties do
    %{
      :environment => Application.get_env(:app, :env),
      :version => @project_version,
      :graphql => AppWeb.Router.graphql_default_url()
      # :runtime => @runtime_version
    }
  end

  def runtime_version do

  end
end
