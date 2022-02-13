let
  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2aCjAlnytwZXW885Xb2psza20SiMTSb0qIbYmmt+Sf";
  system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDuZvWKF/nMnKWHP3gbBveOOWVmpdYmvrG5sXL19okXi";
  systems = [ system1 system2 ];
in
{
  "password-g.age".publicKeys = systems;
  "password-root.age".publicKeys = systems;
}
