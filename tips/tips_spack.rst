
Getting started
======================

Do some basic configuration::

      spack bootstrap

Most importantly, it gets the module system built and installed.

Basic commands
======================

See what packages are available::

      spack list

See what packages are installed::

      spack find

See where installed packages are installed on filesystem::

      spack find --paths

See where a single installed package are installed on filesystem::

      spack find --paths trilinos

Find all packages using mpich::

      spack find ^mpich
      

But want the location, this might be easier::

   spack location --install-dir trilinos

Get hash of the different versions::

      spack find --long trilinos

Get dependency tree of the hash::

      spack find -d /nznbz5b

Show variants and flags of package::

      spack find --variants --show-flags trilinos@12.12.1

Useful to see everything (and use short version)::

      spack find --Lv trilinos


See what package versions are availible to be isntalled::

      spack install <pkg name>
      spack install <pkg name> ^<dep> %<compiler>

Find implementations of a virtual package::

      spack providers mpi

Find extensions of package::

      spack extenions python

For modules (tcl)::

      spack load python

For dotkit (similar to modules)::

      spack load python

For 'permanent activation'::

      spack load python

Views::

      spack view --verbose symlink -i myview  trilinos 
      spack view --verbose symlink myview  moab

The  -i above is to ignore conflicts and there are conflicts between superlu and
SuiteSparse.

The above do not work very well if you have multiple installed.  So you need to
need to use::

      spack find -lv moab
      spack find -lv trilinos
      spack find -dlv moab
      spack find -dlv trilinos

To find the versions that work.  For me, I could then::

      spack view --verbose symlink myview moab^/oajmavs



Spec options
======================

Full spec list:

* Package name identifier (``mpileaks`` above)
* ``@`` Optional version specifier (``@1.2:1.4``)
* ``%`` Optional compiler specifier, with an optional compiler version
  (``gcc`` or ``gcc@4.7.3``)
* ``+`` or ``-`` or ``~`` Optional variant specifiers (``+debug``,
  ``-qt``, or ``~qt``) for boolean variants
* ``name=<value>`` Optional variant specifiers that are not restricted to
  boolean variants
* ``name=<value>`` Optional compiler flag specifiers. Valid flag names are
  ``cflags``, ``cxxflags``, ``fflags``, ``cppflags``, ``ldflags``, and ``ldlibs``.
* ``target=<value> os=<value>`` Optional architecture specifier
  (``target=haswell os=CNL10``)
* ``^`` Dependency specs (``^callpath@1.1``)

Spec example::

   mpileaks @1.2:1.4 %gcc@4.7.5 +debug -qt arch=bgq_os ^callpath @1.1 %gcc@4.7.2




From command index
====================


+=================+========================================================+
| Category        |  Commands                                              |
+=================+========================================================+
| Administration  | bootstrap clone reindex                                |
+-----------------+--------------------------------------------------------+
| Query packages  | dependencies dependents find graph info list providers |
+-----------------+--------------------------------------------------------+
| Build packages  | build clean configure diy env fetch install log-parse  |
|                 | patch restage setup spec stage uninstall               |
+-----------------+--------------------------------------------------------+
| Configuration   | config mirror repo                                     |
+-----------------+--------------------------------------------------------+
| Developer       | blame commands debug flake8 pkg pydoc python test url  |
+-----------------+--------------------------------------------------------+
| Environment     | cd load location module unload unuse use view          |
+-----------------+--------------------------------------------------------+
| Extensions      | activate deactivate extensions                         |
+-----------------+--------------------------------------------------------+
| More help       | docs help                                              |
+-----------------+--------------------------------------------------------+
| Create packages | buildcache checksum create edit gpg versions           |
+-----------------+--------------------------------------------------------+
| System          | arch compiler compilers                                |
+-----------------+--------------------------------------------------------+

