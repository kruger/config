Usage
-----

fzf will launch interactive finder, read the list from STDIN, and write
the selected item to STDOUT.

.. code:: sh

   find * -type f | fzf > selected

Without STDIN pipe, fzf will use find command to fetch the list of files
excluding hidden ones. (You can override the default command with
``FZF_DEFAULT_COMMAND``)

.. code:: sh

   vim $(fzf)

Using the finder
^^^^^^^^^^^^^^^^

-  ``CTRL-J`` / ``CTRL-K`` (or ``CTRL-N`` / ``CTRL-P``) to move cursor
   up and down
-  ``Enter`` key to select the item, ``CTRL-C`` / ``CTRL-G`` / ``ESC``
   to exit
-  On multi-select mode (``-m``), ``TAB`` and ``Shift-TAB`` to mark
   multiple items
-  Emacs style key bindings
-  Mouse: scroll, click, double-click; shift-click and shift-scroll on
   multi-select mode

Layout
^^^^^^

fzf by default starts in fullscreen mode, but you can make it start
below the cursor with ``--height`` option.

.. code:: sh

   vim $(fzf --height 40%)

Also, check out ``--reverse`` and ``--layout`` options if you prefer
“top-down” layout instead of the default “bottom-up” layout.

.. code:: sh

   vim $(fzf --height 40% --reverse)

You can add these options to ``$FZF_DEFAULT_OPTS`` so that they’re
applied by default. For example,

.. code:: sh

   export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

Search syntax
^^^^^^^^^^^^^

Unless otherwise specified, fzf starts in “extended-search mode” where
you can type in multiple search terms delimited by spaces.
e.g. ``^music .mp3$ sbtrkt !fire``

+-------------+--------------------------+--------------------------+
| Token       | Match type               | Description              |
+=============+==========================+==========================+
| ``sbtrkt``  | fuzzy-match              | Items that match         |
|             |                          | ``sbtrkt``               |
+-------------+--------------------------+--------------------------+
| ``'wild``   | exact-match (quoted)     | Items that include       |
|             |                          | ``wild``                 |
+-------------+--------------------------+--------------------------+
| ``^music``  | prefix-exact-match       | Items that start with    |
|             |                          | ``music``                |
+-------------+--------------------------+--------------------------+
| ``.mp3$``   | suffix-exact-match       | Items that end with      |
|             |                          | ``.mp3``                 |
+-------------+--------------------------+--------------------------+
| ``!fire``   | inverse-exact-match      | Items that do not        |
|             |                          | include ``fire``         |
+-------------+--------------------------+--------------------------+
| ``!^music`` | in                       | Items that do not start  |
|             | verse-prefix-exact-match | with ``music``           |
+-------------+--------------------------+--------------------------+
| ``!.mp3$``  | in                       | Items that do not end    |
|             | verse-suffix-exact-match | with ``.mp3``            |
+-------------+--------------------------+--------------------------+

If you don’t prefer fuzzy matching and do not wish to “quote” every
word, start fzf with ``-e`` or ``--exact`` option. Note that when
``--exact`` is set, ``'``-prefix “unquotes” the term.

A single bar character term acts as an OR operator. For example, the
following query matches entries that start with ``core`` and end with
either ``go``, ``rb``, or ``py``.

::

   ^core go$ | rb$ | py$

Environment variables
^^^^^^^^^^^^^^^^^^^^^

-  ``FZF_DEFAULT_COMMAND``

   -  Default command to use when input is tty
   -  e.g. ``export FZF_DEFAULT_COMMAND='fd --type f'``

-  ``FZF_DEFAULT_OPTS``

   -  Default options
   -  e.g. ``export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"``

Examples
--------

Many useful examples can be found on `the wiki
page <https://github.com/junegunn/fzf/wiki/examples>`__. Feel free to
add your own as well.

Key bindings for command-line
-----------------------------

The install script will setup the following key bindings for bash, zsh,
and fish.

-  ``CTRL-T`` - Paste the selected files and directories onto the
   command-line

   -  Set ``FZF_CTRL_T_COMMAND`` to override the default command
   -  Set ``FZF_CTRL_T_OPTS`` to pass additional options

-  ``CTRL-R`` - Paste the selected command from history onto the
   command-line

   -  If you want to see the commands in chronological order, press
      ``CTRL-R`` again which toggles sorting by relevance
   -  Set ``FZF_CTRL_R_OPTS`` to pass additional options

-  ``ALT-C`` - cd into the selected directory

   -  Set ``FZF_ALT_C_COMMAND`` to override the default command
   -  Set ``FZF_ALT_C_OPTS`` to pass additional options

If you’re on a tmux session, you can start fzf in a tmux split-pane or
in a tmux popup window by setting ``FZF_TMUX_OPTS`` (e.g. ``-d 40%``).
See ``fzf-tmux --help`` for available options.

More tips can be found on `the wiki
page <https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings>`__.

Fuzzy completion for bash and zsh
---------------------------------

Files and directories
^^^^^^^^^^^^^^^^^^^^^

Fuzzy completion for files and directories can be triggered if the word
before the cursor ends with the trigger sequence, which is by default
``**``.

-  ``COMMAND [DIRECTORY/][FUZZY_PATTERN]**<TAB>``

.. code:: sh

   # Files under the current directory
   # - You can select multiple items with TAB key
   vim **<TAB>

   # Files under parent directory
   vim ../**<TAB>

   # Files under parent directory that match `fzf`
   vim ../fzf**<TAB>

   # Files under your home directory
   vim ~/**<TAB>


   # Directories under current directory (single-selection)
   cd **<TAB>

   # Directories under ~/github that match `fzf`
   cd ~/github/fzf**<TAB>

Process IDs
^^^^^^^^^^^

Fuzzy completion for PIDs is provided for kill command. In this case,
there is no trigger sequence; just press the tab key after the kill
command.

.. code:: sh

   # Can select multiple processes with <TAB> or <Shift-TAB> keys
   kill -9 <TAB>

Host names
^^^^^^^^^^

For ssh and telnet commands, fuzzy completion for hostnames is provided.
The names are extracted from /etc/hosts and ~/.ssh/config.

.. code:: sh

   ssh **<TAB>
   telnet **<TAB>

Environment variables / Aliases
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: sh

   unset **<TAB>
   export **<TAB>
   unalias **<TAB>

Settings
^^^^^^^^

.. code:: sh

   # Use ~~ as the trigger sequence instead of the default **
   export FZF_COMPLETION_TRIGGER='~~'

   # Options to fzf command
   export FZF_COMPLETION_OPTS='+c -x'

   # Use fd (https://github.com/sharkdp/fd) instead of the default find
   # command for listing path candidates.
   # - The first argument to the function ($1) is the base path to start traversal
   # - See the source code (completion.{bash,zsh}) for the details.
   _fzf_compgen_path() {
     fd --hidden --follow --exclude ".git" . "$1"
   }

   # Use fd to generate the list for directory completion
   _fzf_compgen_dir() {
     fd --type d --hidden --follow --exclude ".git" . "$1"
   }

   # (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
   # - The first argument to the function is the name of the command.
   # - You should make sure to pass the rest of the arguments to fzf.
   _fzf_comprun() {
     local command=$1
     shift

     case "$command" in
       cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
       export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
       ssh)          fzf "$@" --preview 'dig {}' ;;
       *)            fzf "$@" ;;
     esac
   }

Supported commands
^^^^^^^^^^^^^^^^^^

On bash, fuzzy completion is enabled only for a predefined set of
commands (``complete | grep _fzf`` to see the list). But you can enable
it for other commands as well by using ``_fzf_setup_completion`` helper
function.

.. code:: sh

   # usage: _fzf_setup_completion path|dir|var|alias|host COMMANDS...
   _fzf_setup_completion path ag git kubectl
   _fzf_setup_completion dir tree

Custom fuzzy completion
^^^^^^^^^^^^^^^^^^^^^^^

**(Custom completion API is experimental and subject to change)**

For a command named *“COMMAND”*, define ``_fzf_complete_COMMAND``
function using ``_fzf_complete`` helper.

.. code:: sh

   # Custom fuzzy completion for "doge" command
   #   e.g. doge **<TAB>
   _fzf_complete_doge() {
     _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
       echo very
       echo wow
       echo such
       echo doge
     )
   }

-  The arguments before ``--`` are the options to fzf.
-  After ``--``, simply pass the original completion arguments unchanged
   (``"$@"``).
-  Then, write a set of commands that generates the completion
   candidates and feed its output to the function using process
   substitution (``< <(...)``).

zsh will automatically pick up the function using the naming convention
but in bash you have to manually associate the function with the command
using the ``complete`` command.

.. code:: sh

   [ -n "$BASH" ] && complete -F _fzf_complete_doge -o default -o bashdefault doge

If you need to post-process the output from fzf, define
``_fzf_complete_COMMAND_post`` as follows.

.. code:: sh

   _fzf_complete_foo() {
     _fzf_complete --multi --reverse --header-lines=3 -- "$@" < <(
       ls -al
     )
   }

   _fzf_complete_foo_post() {
     awk '{print $NF}'
   }

   [ -n "$BASH" ] && complete -F _fzf_complete_foo -o default -o bashdefault foo

Executing external programs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can set up key bindings for starting external processes without
leaving fzf (``execute``, ``execute-silent``).

.. code:: bash

   # Press F1 to open the file with less without leaving fzf
   # Press CTRL-Y to copy the line to clipboard and aborts fzf (requires pbcopy)
   fzf --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'

See *KEY BINDINGS* section of the man page for details.

Reloading the candidate list
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By binding ``reload`` action to a key or an event, you can make fzf
dynamically reload the candidate list. See
https://github.com/junegunn/fzf/issues/1750 for more details.

1. Update the list of processes by pressing CTRL-R
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: sh

   FZF_DEFAULT_COMMAND='ps -ef' \
     fzf --bind 'ctrl-r:reload($FZF_DEFAULT_COMMAND)' \
         --header 'Press CTRL-R to reload' --header-lines=1 \
         --height=50% --layout=reverse

2. Switch between sources by pressing CTRL-D or CTRL-F
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: sh

   FZF_DEFAULT_COMMAND='find . -type f' \
     fzf --bind 'ctrl-d:reload(find . -type d),ctrl-f:reload($FZF_DEFAULT_COMMAND)' \
         --height=50% --layout=reverse

3. Interactive ripgrep integration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following example uses fzf as the selector interface for ripgrep. We
bound ``reload`` action to ``change`` event, so every time you type on
fzf, the ripgrep process will restart with the updated query string
denoted by the placeholder expression ``{q}``. Also, note that we used
``--phony`` option so that fzf doesn’t perform any secondary filtering.

.. code:: sh

   INITIAL_QUERY=""
   RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
   FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
     fzf --bind "change:reload:$RG_PREFIX {q} || true" \
         --ansi --phony --query "$INITIAL_QUERY" \
         --height=50% --layout=reverse

If ripgrep doesn’t find any matches, it will exit with a non-zero exit
status, and fzf will warn you about it. To suppress the warning message,
we added ``|| true`` to the command, so that it always exits with 0.

Preview window
~~~~~~~~~~~~~~

When the ``--preview`` option is set, fzf automatically starts an
external process with the current line as the argument and shows the
result in the split window. Your ``$SHELL`` is used to execute the
command with ``$SHELL -c COMMAND``. The window can be scrolled using the
mouse or custom key bindings.

.. code:: bash

   # {} is replaced with the single-quoted string of the focused line
   fzf --preview 'cat {}'

Preview window supports ANSI colors, so you can use any program that
syntax-highlights the content of a file, such as
`Bat <https://github.com/sharkdp/bat>`__ or
`Highlight <http://www.andre-simon.de/doku/highlight/en/highlight.php>`__:

.. code:: bash

   fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'

You can customize the size, position, and border of the preview window
using ``--preview-window`` option, and the foreground and background
color of it with ``--color`` option. For example,

.. code:: bash

   fzf --height 40% --layout reverse --info inline --border \
       --preview 'file {}' --preview-window down:1:noborder \
       --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'

See the man page (``man fzf``) for the full list of options.

For more advanced examples, see `Key bindings for git with
fzf <https://junegunn.kr/2016/07/fzf-git/>`__
(`code <https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236>`__).

--------------

Since fzf is a general-purpose text filter rather than a file finder,
**it is not a good idea to add ``--preview`` option to your
``$FZF_DEFAULT_OPTS``**.

.. code:: sh

   # *********************
   # ** DO NOT DO THIS! **
   # *********************
   export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

   # bat doesn't work with any input other than the list of files
   ps -ef | fzf
   seq 100 | fzf
   history | fzf

Tips
----

Respecting ``.gitignore``
^^^^^^^^^^^^^^^^^^^^^^^^^

You can use `fd <https://github.com/sharkdp/fd>`__,
`ripgrep <https://github.com/BurntSushi/ripgrep>`__, or `the silver
searcher <https://github.com/ggreer/the_silver_searcher>`__ instead of
the default find command to traverse the file system while respecting
``.gitignore``.

.. code:: sh

   # Feed the output of fd into fzf
   fd --type f | fzf

   # Setting fd as the default source for fzf
   export FZF_DEFAULT_COMMAND='fd --type f'

   # Now fzf (w/o pipe) will use fd instead of find
   fzf

   # To apply the command to CTRL-T as well
   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

If you want the command to follow symbolic links and don’t want it to
exclude hidden files, use the following command:

.. code:: sh

   export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

Fish shell
^^^^^^^^^^

``CTRL-T`` key binding of fish, unlike those of bash and zsh, will use
the last token on the command-line as the root directory for the
recursive search. For instance, hitting ``CTRL-T`` at the end of the
following command-line

.. code:: sh

   ls /var/

will list all files and directories under ``/var/``.

When using a custom ``FZF_CTRL_T_COMMAND``, use the unexpanded ``$dir``
variable to make use of this feature. ``$dir`` defaults to ``.`` when
the last token is not a valid directory. Example:

.. code:: sh

   set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
