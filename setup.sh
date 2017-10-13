git clone --bare git@github.com:6A/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
     echo "Checked out config.";
else
   echo "Backing up pre-existing dot files.";
   config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

# Disable 'running as root' warning in OPAM.
mv /usr/bin/opam /usr/bin/opam-unsafe
echo "#!/bin/bash">/usr/bin/opam
echo "opam-unsafe --safe \$@">>/usr/bin/opam
chmod +x /usr/bin/opam
