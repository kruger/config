Simple search
~~~~~~~~~~~~~

*fd* is designed to find entries in your filesystem. The most basic
search you can perform is to run *fd* with a single argument: the search
pattern. For example, assume that you want to find an old script of
yours (the name included ``netflix``):

.. code:: bash

   > fd netfl
   Software/python/imdb-ratings/netflix-details.py

If called with just a single argument like this, *fd* searches the
current directory recursively for any entries that *contain* the pattern
``netfl``.

Regular expression search
~~~~~~~~~~~~~~~~~~~~~~~~~

The search pattern is treated as a regular expression. Here, we search
for entries that start with ``x`` and end with ``rc``:

.. code:: bash

   > cd /etc
   > fd '^x.*rc$'
   X11/xinit/xinitrc
   X11/xinit/xserverrc

The regular expression syntax used by fd is documented here:

https://docs.rs/regex/1.0.0/regex/#syntax

Specifying the root directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If we want to search a specific directory, it can be given as a second
argument to *fd*:

.. code:: bash

   > fd passwd /etc
   /etc/default/passwd
   /etc/pam.d/passwd
   /etc/passwd

Running *fd* without any arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*fd* can be called with no arguments. This is very useful to get a quick
overview of all entries in the current directory, recursively (similar
to ``ls -R``):

.. code:: bash

   > cd fd/tests
   > fd
   testenv
   testenv/mod.rs
   tests.rs

If you want to use this functionality to list all files in a given
directory, you have to use a catch-all pattern such as ``.`` or ``^``:

.. code:: bash

   > fd . fd/tests/
   testenv
   testenv/mod.rs
   tests.rs

Searching for a particular file extension
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Often, we are interested in all files of a particular type. This can be
done with the ``-e`` (or ``--extension``) option. Here, we search for
all Markdown files in the fd repository:

.. code:: bash

   > cd fd
   > fd -e md
   CONTRIBUTING.md
   README.md

The ``-e`` option can be used in combination with a search pattern:

.. code:: bash

   > fd -e rs mod
   src/fshelper/mod.rs
   src/lscolors/mod.rs
   tests/testenv/mod.rs

Hidden and ignored files
~~~~~~~~~~~~~~~~~~~~~~~~

By default, *fd* does not search hidden directories and does not show
hidden files in the search results. To disable this behavior, we can use
the ``-H`` (or ``--hidden``) option:

.. code:: bash

   > fd pre-commit
   > fd -H pre-commit
   .git/hooks/pre-commit.sample

If we work in a directory that is a Git repository (or includes Git
repositories), *fd* does not search folders (and does not show files)
that match one of the ``.gitignore`` patterns. To disable this behavior,
we can use the ``-I`` (or ``--no-ignore``) option:

.. code:: bash

   > fd num_cpu
   > fd -I num_cpu
   target/debug/deps/libnum_cpus-f5ce7ef99006aa05.rlib

To really search *all* files and directories, simply combine the hidden
and ignore features to show everything (``-HI``).


Misc
~~~~

fd 806.png -x mv {} vultr     # move file to vultr folder
fd "2021.*" -X  mediainfo     # open result in `mediainfo res1 res2`
fd prop -x mpv &              # open result in `mpv res1; mpv res2` in background

# these two are the same; get modified in past 24 hrs
fd -I -t f --changed-within 24h
find -type f -mtime -1 -print0

# for most cmds you don't need the {} syntax, but mv requires it
fd "2021.*" -X mv {} ~/scratch/tmp7

fd -e SC2Replay -X stat -c "%y    %n" | sort

# lookup based on filename, curr dir only, and delete
find -maxdepth 1 | xargs rm -v
fd -d1 "sc2rep-(linux|win|mac)" -X rm -v


Excluding specific files or directories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes we want to ignore search results from a specific subdirectory.
For example, we might want to search all hidden files and directories
(``-H``) but exclude all matches from ``.git`` directories. We can use
the ``-E`` (or ``--exclude``) option for this. It takes an arbitrary
glob pattern as an argument:

.. code:: bash

   > fd -H -E .git …

We can also use this to skip mounted directories:

.. code:: bash

   > fd -E /mnt/external-drive …

.. or to skip certain file types:

.. code:: bash

   > fd -E '*.bak' …

To make exclude-patterns like these permanent, you can create a
``.fdignore`` file. They work like ``.gitignore`` files, but are
specific to ``fd``. For example:

.. code:: bash

   > cat ~/.fdignore
   /mnt/external-drive
   *.bak

Note: ``fd`` also supports ``.ignore`` files that are used by other
programs such as ``rg`` or ``ag``.

If you want ``fd`` to ignore these patterns globally, you can put them
in ``fd``\ ’s global ignore file. This is usually located in
``~/.config/fd/ignore`` in macOS or Linux, and ``%APPDATA%\fd\ignore``
in Windows.

Using fd with ``xargs`` or ``parallel``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If we want to run a command on all search results, we can pipe the
output to ``xargs``:

.. code:: bash

   > fd -0 -e rs | xargs -0 wc -l

Here, the ``-0`` option tells *fd* to separate search results by the
NULL character (instead of newlines). In the same way, the ``-0`` option
of ``xargs`` tells it to read the input in this way.

Deleting files
~~~~~~~~~~~~~~

You can use ``fd`` to remove all files and directories that are matched
by your search pattern. If you only want to remove files, you can use
the ``--exec-batch``/``-X`` option to call ``rm``. For example, to
recursively remove all ``.DS_Store`` files, run:

.. code:: bash

   > fd -H '^\.DS_Store$' -tf -X rm

If you are unsure, always call ``fd`` without ``-X rm`` first.
Alternatively, use ``rm``\ s “interactive” option:

.. code:: bash

   > fd -H '^\.DS_Store$' -tf -X rm -i

If you also want to remove a certain class of directories, you can use
the same technique. You will have to use ``rm``\ s
``--recursive``/``-r`` flag to remove directories.

Note: there are scenarios where using ``fd … -X rm -r`` can cause race
conditions: if you have a path like ``…/foo/bar/foo/…`` and want to
remove all directories named ``foo``, you can end up in a situation
where the outer ``foo`` directory is removed first, leading to
(harmless) *“‘foo/bar/foo’: No such file or directory”* errors in the
``rm`` call.

Troubleshooting
~~~~~~~~~~~~~~~

``fd`` does not find my file!
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Remember that ``fd`` ignores hidden directories and files by default. It
also ignores patterns from ``.gitignore`` files. If you want to make
sure to find absolutely every possible file, always use the options
``-H`` and ``-I`` to disable these two features:

.. code:: bash

   > fd -HI …

``fd`` doesn’t seem to interpret my regex pattern correctly
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A lot of special regex characters (like ``[]``, ``^``, ``$``, ..) are
also special characters in your shell. If in doubt, always make sure to
put single quotes around the regex pattern:

.. code:: bash

   > fd '^[A-Z][0-9]+$'

If your pattern starts with a dash, you have to add ``--`` to signal the
end of command line options. Otherwise, the pattern will be interpreted
as a command-line option. Alternatively, use a character class with a
single hyphen character:

.. code:: bash

   > fd -- '-pattern'
   > fd '[-]pattern'

Colorized output
----------------

``fd`` can colorize files by extension, just like ``ls``. In order for
this to work, the environment variable
```LS_COLORS`` <https://linux.die.net/man/5/dir_colors>`__ has to be
set. Typically, the value of this variable is set by the ``dircolors``
command which provides a convenient configuration format to define
colors for different file formats. On most distributions, ``LS_COLORS``
should be set already. If you are on Windows or if you are looking for
alternative, more complete (or more colorful) variants, see
`here <https://github.com/sharkdp/vivid>`__,
`here <https://github.com/seebi/dircolors-solarized>`__ or
`here <https://github.com/trapd00r/LS_COLORS>`__.

``fd`` also honors the ```NO_COLOR`` <https://no-color.org/>`__
environment variable.

Parallel command execution
--------------------------

If the ``-x``/``--exec`` option is specified alongside a command
template, a job pool will be created for executing commands in parallel
for each discovered path as the input. The syntax for generating
commands is similar to that of GNU Parallel:

-  ``{}``: A placeholder token that will be replaced with the path of
   the search result (``documents/images/party.jpg``).
-  ``{.}``: Like ``{}``, but without the file extension
   (``documents/images/party``).
-  ``{/}``: A placeholder that will be replaced by the basename of the
   search result (``party.jpg``).
-  ``{//}``: Uses the parent of the discovered path
   (``documents/images``).
-  ``{/.}``: Uses the basename, with the extension removed (``party``).

.. code:: bash

   # Convert all jpg files to png files:
   fd -e jpg -x convert {} {.}.png

   # Unpack all zip files (if no placeholder is given, the path is appended):
   fd -e zip -x unzip

   # Convert all flac files into opus files:
   fd -e flac -x ffmpeg -i {} -c:a libopus {.}.opus

   # Count the number of lines in Rust files (the command template can be terminated with ';'):
   fd -x wc -l \; -e rs

The number of threads used for command execution can be set with the
``--threads``/``-j`` option.

Using fd with ``fzf``
---------------------

You can use *fd* to generate input for the command-line fuzzy finder
`fzf <https://github.com/junegunn/fzf>`__:

.. code:: bash

   export FZF_DEFAULT_COMMAND='fd --type file'
   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

Then, you can type ``vim <Ctrl-T>`` on your terminal to open fzf and
search through the fd-results.

Alternatively, you might like to follow symbolic links and include
hidden files (but exclude ``.git`` folders):

.. code:: bash

   export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

You can even use fd’s colored output inside fzf by setting:

.. code:: bash

   export FZF_DEFAULT_COMMAND="fd --type file --color=always"
   export FZF_DEFAULT_OPTS="--ansi"

For more details, see the `Tips
section <https://github.com/junegunn/fzf#tips>`__ of the fzf README.

