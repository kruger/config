

Basic commands
======================

Find out information about installed conda::

      conda info

Upgrade anaconda::

      conda update anaconda

See what packages are availible (in current environment)::

      conda list

See what package versions are availible to be isntalled::

      conda search <pkg name>


Managing environments
======================

See what is available::

      conda-env list

Activate an env::

      source activate <env>

Create an env::

      conda create <env name> <conda package>

Generally it is better to not put it into the anaconda/env directory where it
goes by default, because you will want to package it up in some way (version
control, etc.)::

      conda create --prefix $HOME/yellowblue python=3.6

The env will be the full the path `$HOME/yellowblue`::

      source activate $HOME/yellowblue 

but it WILL NOT be listed under `conda env list`.  Also, when activated, it
appears with the full directory name which can be long.  Need to figure this
out.

Add a package to an env::

      conda install <package name>  # While in env

And remove a package::

      conda remove <package name>  # While in env

