# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # My Adds 
  services.gvfs.enable = true;
  nix.gc.automatic = true;
  users.defaultUserShell = pkgs.zsh;
  services.mpd = {
  enable = true;
  musicDirectory = "/home/kvl/Music";

  # Optional:
  network.listenAddress = "any"; # if you want to allow non-localhost connections
  startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "NixBox"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN.utf8";

  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    # displayManager.defaultSession = "none+awesome";
    desktopManager.xterm.enable = false;
    # disable automatic screen blanking and stuff, we'll do it manually instead
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kvl = {
    isNormalUser = true;
    description = "Kavi Arya";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   neovim 
   kitty
   wget
   curl
   neofetch
   python
   firefox
   pcmanfm
   xclip
   mpv
   htop
   pavucontrol
   nodejs 
   git
   exa 
   awesome
   lxappearance
   zsh
   gcc 
   onlyoffice-bin
   zathura
   vieb
   lf
   youtube-dl
   yt-dlp
   mpd
   ncmpcpp
   bspwm
   sxiv
   sxhkd
   cava
   pulsemixer
   keepassxc
   xsel
   brightnessctl
   xorg.xinput
   xorg.xsetroot
   undervolt
   ekam
   python39Packages.pynvim
   cargo
   nodePackages.npm
   rofi
   gnumake
   gnutar 
   gzip 
   coreutils 
   gawk 
   gnused 
   gnugrep 
   binutils.bintools 
   patchelf 
   findutils
   unzip
   xorg.xinit
   libsForQt5.kdeconnect-kde
   obsidian
   picom
   xorg.libX11
   imlib2
   imlib2-nox
   imlib
   spotify
   spotify-tui
   spotify-tray
   networkmanagerapplet
   pnmixer
   jmtpfs
  ];

 
  # NVIDIA drivers are unfree.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
