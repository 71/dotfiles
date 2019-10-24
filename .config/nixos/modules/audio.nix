{ ... }:

{
  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;

      tcp.enable = true;
      tcp.anonymousClients.allowedIpRanges = ["127.0.0.1"];
    };
  };
}
