defmodule AppWeb.ServerPropertiesView do
  use AppWeb, :view

  @project_version Mix.Project.config[:version]
  # @runtime_version :os.cmd(:"elixir --version | grep Elixir")

  def properties do
    %{
      :environment => Mix.env(),
      :version => @project_version,
      # :runtime => @runtime_version
    }
  end

  def runtime_version do

  end
end
