# Workaround while I'm trying to get `agenix` to work.
{ ... }:

{
  users.users.g.hashedPassword = abort "FIXME: add hash";
  users.users.root.hashedPassword = abort "FIXME: add hash";
}
