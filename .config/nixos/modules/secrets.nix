{ ... }:

{
  age.identityPaths = [
    "/home/g/.ssh/id_ed25519"
  ];

  age.secrets = {
    password-g.file = ../secrets/password-g.age;
    password-root.file = ../secrets/password-root.age;
  };
}
