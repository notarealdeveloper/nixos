# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  fileSystems."/home/jason/Desktop" = {
    device = "/dev/disk/by-uuid/4bdc5d0f-19b2-410d-88ca-a8892b1db448";
    fsType = "ext4";
  };

  #networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

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
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    warn-dirty = false
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gcc
    gnumake
    jq
    tree
    wget
    acpi
    mlocate
    binutils
    srm
    bash-completion
    nix-bash-completions
    vim-full
    inotify-tools
    imagemagick
    xdotool
    xclip
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jason = {
    isNormalUser = true;
    description = "Jason";
    extraGroups = [ "networkmanager" "wheel" "mlocate" ];
    packages = with pkgs; [

        # desktop
        conky
        evince
        gedit
        dropbox
        gnome.eog
        numix-icon-theme-circle
        numix-gtk-theme

        # media
        vlc
        yt-dlp
        firefox
        google-chrome

        # dev
        obsidian
        github-cli
        cargo

        # fun
        cowsay
        xcowsay
        cmatrix
        lolcat
        asciiquarium

        # work
        teams-for-linux 

        # kids today
        helix
        zellij
        nnn                 # terminal file manager
        ripgrep             # recursively searches directories for a regex pattern
        fzf                 # A command-line fuzzy finder
        glow                # markdown previewer in terminal
        nix-output-monitor  # nom command, works like nix with better output

        # fonts
        nerdfonts
        terminus-nerdfont
        noto-fonts-emoji
        source-han-sans
        source-han-sans-japanese
        source-han-sans-korean
        source-han-sans-simplified-chinese
        source-han-sans-traditional-chinese
        source-han-serif
        source-han-serif-japanese
        source-han-serif-korean
        source-han-serif-simplified-chinese
        source-han-serif-traditional-chinese

        (python311.withPackages (ps: with ps; [
          pip
          ipython
          requests
          beautifulsoup4
          google-auth-httplib2
          google-auth-oauthlib
          google-api-python-client
          torch
          pandas
          transformers
          sentence-transformers
        ]))

    ];    
  };      
          
  # for obsidian
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  users.groups.mlocate = {};

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
