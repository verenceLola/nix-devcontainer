{ ... }: {
  imports = [ ./disk.nix ./boot.nix ../common/graphics.nix ];

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
}
