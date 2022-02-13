{ ... }:

{
  age.identityPaths = [
    ../secrets
  ];

  age.secrets = {
    password-g.file = ../secrets/password-g.age;
    password-root.file = ../secrets/password-root.age;
  };
}
