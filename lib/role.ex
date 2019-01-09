alias Converge.{All, FilePresent, RedoAfterMeet, Util}

defmodule RoleRemoteLuksUnlock do
	require Util
	import Util, only: [conf_file: 1, conf_dir: 1, path_expand_content: 1, marker: 1]

	def role(_tags \\ []) do
		authorized_keys = [
			path_expand_content("~/.ssh/id_rsa.pub") |> String.trim_trailing
		]
		%{
			desired_packages: ["dropbear-initramfs"],
			post_install_unit:
				%RedoAfterMeet{
					marker: marker("dropbear-initramfs"),
					unit:
						%All{units: [
							conf_dir("/etc/dropbear-initramfs"),
							conf_file("/etc/dropbear-initramfs/config"),
							%FilePresent{
								path:    "/etc/dropbear-initramfs/authorized_keys",
								content: authorized_keys ++ [""] |> Enum.join("\n"),
								mode:    0o600,
							},
						]},
					trigger: fn -> {_, 0} = System.cmd("update-initramfs", ["-u", "-k", "all"]) end
				}
		}
	end
end
