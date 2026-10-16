//go:build !distro_binary

package main

func configureEditionCommands() {
	updateCmd.AddCommand(updateCheckCmd)
	registryCmd.AddCommand(registryListCmd, registryAddCmd, registryRemoveCmd)
	rootCmd.AddCommand(updateCmd)
}
