defmodule RoleRemoteLuksUnlock.Mixfile do
	use Mix.Project

	def project do
		[
			app:             :role_remote_luks_unlock,
			version:         "0.1.0",
			elixir:          ">= 1.4.0",
			build_embedded:  Mix.env == :prod,
			start_permanent: Mix.env == :prod,
			deps:            deps()
		]
	end

	defp deps do
		[
			{:converge, ">= 0.1.0"},
		]
	end
end
