===============================
TMux Cheat Sheet
===============================

Basic commands
--------------

Most important:  All commands begin with CTRL-b (^b)


Here are file spacing cases:

 - new session with name::

   tmux new -s session-name

 - detach while in session::

   tmux detach

   ^b d

 - Reattach to session::

   tmux a # First available session

   tmux a -t session-name

 - Kill a session::

   tmux kill-session -t session-name

 - List commands:

    + list-buffers
    + list-clients
    + list-commands
    + list-keys
    + list-panes
    + list-sessions
    + list-windows

 - List commands:

    + list-buffers
    + list-clients
    + list-commands
    + list-keys
    + list-panes
    + list-sessions
    + list-windows

Ctrl-b options reference
------------------------

Basics
======

? get help


Session management
==================

s list sessions
$ rename the current session d detach from the current session


Windows
=======

Commands:: 

      c create a new window
      , rename the current window
      w list windows
      | split horizontally
      - split vertically
      CTRL-{j,k,h,l}   Change pane focus
      # Rebound in .tmux.conf.  These are the defaults:
      # % split horizontally
      # "  split vertically
      #n change to the next window
      #p change to the previous window
      0 to 9 select windows 0 through 9

Panes
=====

% create a horizontal pane
" create a vertical pane
h move to the left pane. *
j move to the pane below *
l move to the right pane *
k move to the pane above *
k move to the pane above *
q show pane numbers
o toggle between panes
} swap with next pane
{ swap with previous pane
! break the pane out of the window
x kill the current pane

Miscellaneous
=============

t show the time in current pane

Resize windows
==============

^b ( Esc + arrow) * n , where n is the number of times you want to resize.

Command-line (^b :)::

      C-b z: make a pane go full screen. Hit C-b z again to shrink it back to its previous size

      :resize-pane -D (Resizes the current pane down)
      :resize-pane -U (Resizes the current pane upward)
      :resize-pane -L (Resizes the current pane left)
      :resize-pane -R (Resizes the current pane right)
      :resize-pane -D 10 (Resizes the current pane down by 10 cells)
      :resize-pane -U 10 (Resizes the current pane upward by 10 cells)
      :resize-pane -L 10 (Resizes the current pane left by 10 cells)
      :resize-pane -R 10 (Resizes the current pane right by 10 cells)


Reference
---------


Session
========

+----------------+----------------------------------------------------+
| **Command**    |  **Action**                                        |
+----------------+----------------------------------------------------+
| no command     | Short-cut for new-session                          |
+----------------+----------------------------------------------------+
| attach-session | Attach or switch to a session                      |
+----------------+----------------------------------------------------+
| choose-session | Put a window into session choice mode              |
+----------------+----------------------------------------------------+
| has-session    | Check and report if a session exists on the server |
+----------------+----------------------------------------------------+
| kill-session   | Destroy a given session                            |
+----------------+----------------------------------------------------+
| list-sessions  | List sessions managed by server                    |
+----------------+----------------------------------------------------+
| lock-session   | Lock all clients attached to a session             |
+----------------+----------------------------------------------------+
| new-session    | Create a new session                               |
+----------------+----------------------------------------------------+
| rename-session | Rename a session                                   |
+----------------+----------------------------------------------------+
|

Window

+---------------------+----------------------------------------------+
| **Command**         |  **Action**                                  |
+---------------------+----------------------------------------------+
| choose-window       | Put a window into window choice              |
+---------------------+----------------------------------------------+
| find-window         | Search for a pattern in windows              |
+---------------------+----------------------------------------------+
| kill-window         | Destroy a given window                       |
+---------------------+----------------------------------------------+
| last-window         | Select the previously selected               |
+---------------------+----------------------------------------------+
| link-window         | Link a window to another                     |
+---------------------+----------------------------------------------+
| list-windows        | List windows of a session                    |
+---------------------+----------------------------------------------+
| move-window         | Move a window to another                     |
+---------------------+----------------------------------------------+
| new-window          | Create a new window                          |
+---------------------+----------------------------------------------+
| next-window         | Move to the next window in a sesssion        |
+---------------------+----------------------------------------------+
| previous-window     | Move to the previous window in session       |
+---------------------+----------------------------------------------+
| rename-window       | Rename a window                              |
+---------------------+----------------------------------------------+
| respawn-window      | Reuse a window in which a command has exited |
+---------------------+----------------------------------------------+
| rotate-window       | Rotate positions of panes in a window        |
+---------------------+----------------------------------------------+
| select-window       | Select a window                              |
+---------------------+----------------------------------------------+
| set-window-option   | Set a window option                          |
+---------------------+----------------------------------------------+
| show-window-options | Show window options                          |
+---------------------+----------------------------------------------+
| split-window        | Splits a pane into two                       |
+---------------------+----------------------------------------------+
| swap-window         | Swap two windows                             |
+---------------------+----------------------------------------------+
| unlink-window       | Unlink a window                              |
+---------------------+----------------------------------------------+


Pane
=====

+---------------------+----------------------------------------------+
| **Command**         |  **Action**                                  |
+---------------------+----------------------------------------------+
| break-pane	Break a pane from an existing into a new window
capture-pane	Capture the contents of a pane to a buffer
display-panes	Display an indicator for each visible pane
join-pane	Split a pane and move an existing one into the new space
kill-pane	Destroy a given pane
last-pane	Select the previously selected pane
list-panes	List panes of a window
move-pane	Move a pane into a new space
pipe-pane	Pipe output from a pane to a shell command
resize-pane	Resize a pane
respawn-pane	Reuse a pane in which a command has exited
select-pane	Make a pane the active one in the window
swap-pane	Swap two panes


Keybindings
============
Shortcut	Action

C-b	Send the prefix key (C-b) through to the application.

Miscellaneous
=============

+----------+--------------------------------------------+
| Shortcut | Action                                     |
+----------+--------------------------------------------+
| C-z      | Suspend the tmux client.                   |
+----------+--------------------------------------------+
| r        | Force redraw of the attached client.       |
+----------+--------------------------------------------+
| t        | Show the time.                             |
+----------+--------------------------------------------+
| ~        | Show previous messages from tmux, if any.  |
+----------+--------------------------------------------+
| f        | Prompt to search for text in open windows. |
+----------+--------------------------------------------+
| d        | Detach the current client.                 |
+----------+--------------------------------------------+
| D        | Choose a client to detach.                 |
+----------+--------------------------------------------+
| ?        | List all key bindings.                     |
+----------+--------------------------------------------+
| :        | Enter the tmux command prompt.             |
+----------+--------------------------------------------+

Copy/Paste
===========


+----------+----------------------------------------------------------+
| Shortcut | Action                                                   |
+----------+----------------------------------------------------------+
| #        | List all paste buffers.                                  |
+----------+----------------------------------------------------------+
| e (conf) | Enter copy (edit) mode to copy text or view the history. |
+----------+----------------------------------------------------------+
| ]        | Paste the most recently copied buffer of text.           |
+----------+----------------------------------------------------------+
| Page     | Up	Enter copy mode and scroll one page up.               |
+----------+----------------------------------------------------------+
| =        | Choose which buffer to paste interactively from a list.  |
+----------+----------------------------------------------------------+
| -        | Delete the most recently copied buffer of text.          |
+----------+----------------------------------------------------------+


Session
========

+----------+-------------------------------------------------------------+
| Shortcut | Action                                                      |
+----------+-------------------------------------------------------------+
| $        | Rename the current session.                                 |
+----------+-------------------------------------------------------------+
| Session  | Traversal                                                   |
+----------+-------------------------------------------------------------+
| Shortcut | Action                                                      |
+----------+-------------------------------------------------------------+
| L        | Switch the attached client back to the last session.        |
+----------+-------------------------------------------------------------+
| s        | Select a new session for the attached client interactively. |
+----------+-------------------------------------------------------------+


Window
=======

+----------+----------------------------------------------------+
| Shortcut | Action                                             |
+----------+----------------------------------------------------+
| c        | Create a new window.                               |
+----------+----------------------------------------------------+
| &        | Kill the current window.                           |
+----------+----------------------------------------------------+
| i        | Display some information about the current window. |
+----------+----------------------------------------------------+
| ,        | Rename the current window.                         |
+----------+----------------------------------------------------+

Window Traversal
=================

+----------+-------------------------------------------------------------+
| Shortcut | Action                                                      |
+----------+-------------------------------------------------------------+
| 0 to 9   | Select windows 0 to 9.                                      |
+----------+-------------------------------------------------------------+
| w        | Choose the current window interactively.                    |
+----------+-------------------------------------------------------------+
| M-n      | Move to the next window with a bell or activity marker.     |
+----------+-------------------------------------------------------------+
| M-p      | Move to the previous window with a bell or activity marker. |
+----------+-------------------------------------------------------------+
| p        | Change to the previous window.                              |
+----------+-------------------------------------------------------------+
| n        | Change to the next window.                                  |
+----------+-------------------------------------------------------------+
| l        | Move to the previously selected window.                     |
+----------+-------------------------------------------------------------+
| '        | Prompt for a window index to select.                        |
+----------+-------------------------------------------------------------+

Window Moving
===============

+----------+------------------------------------------------+
| Shortcut | Action                                         |
+----------+------------------------------------------------+
| .        | Prompt for an index to move the current window |
+----------+------------------------------------------------+

Pane
=====

+----------+--------------------------------------------------+
| Shortcut | Action                                           |
+----------+--------------------------------------------------+
| x        | Kill the current pane.                           |
+----------+--------------------------------------------------+
| q        | Briefly display pane indexes.                    |
+----------+--------------------------------------------------+
| %        | Split the current pane into two, left and right. |
+----------+--------------------------------------------------+
| "        | Split the current pane into two, top and bottom. |
+----------+--------------------------------------------------+

Pane Traversal
==============

+-------------+-----------------------------------------------------+
| Shortcut    | Action                                              |
+-------------+-----------------------------------------------------+
| ;           | Move to the previously active pane.                 |
+-------------+-----------------------------------------------------+
| Up, Down    | Change to the pane above, below, to the left, or to |
| Left, Right | the right of the current pane.                      |
+-------------+-----------------------------------------------------+
| o           | Select the next pane in the current window.         |
+-------------+-----------------------------------------------------+

Pane Moving
===========

+----------+---------------------------------------------------+
| Shortcut | Action                                            |
+----------+---------------------------------------------------+
| C-o      | Rotate the panes in the current window forwards.  |
+----------+---------------------------------------------------+
| M-o      | Rotate the panes in the current window backwards. |
+----------+---------------------------------------------------+
| {        | Swap the current pane with the previous pane.     |
+----------+---------------------------------------------------+
| }        | Swap the current pane with the next pane.         |
+----------+---------------------------------------------------+
| !        | Break the current pane out of the window.         |
+----------+---------------------------------------------------+

Pane Resizing
=============

+-----------------+--------------------------------------------------+
| Shortcut        | Action                                           |
+-----------------+--------------------------------------------------+
| M-1 to M-5      | Arrange panes in one of the five preset layouts: |
|                 | even-horizontal, even-vertical, main-horizontal, |
|                 | main-vertical, or tiled.                         |
+-----------------+--------------------------------------------------+
| C-Up, C-Down    | Resize the current pane in steps of one cell.    |
| C-Left, C-Right |                                                  |
+-----------------+--------------------------------------------------+
| M-Up, M-Down    | Resize the current pane in steps of five cells.  |
| M-Left, M-Right |                                                  |
+-----------------+--------------------------------------------------+

Formats
=============

Copy / paste
+++++++++++++

+---------------+---------------------------------------+
| Variable name | Description                           |
+---------------+---------------------------------------+
| buffer_name   | Name of buffer                        |
+---------------+---------------------------------------+
| buffer_sample | Sample of start of buffer             |
+---------------+---------------------------------------+
| buffer_size   | Size of the specified buffer in bytes |
+---------------+---------------------------------------+

Clients
+++++++

+---------------------+---------------------------------------+
| Variable name       | Description                           |
+---------------------+---------------------------------------+
| client_activity     | Integer time client last had activity |
+---------------------+---------------------------------------+
| client_created      | Integer time client created           |
+---------------------+---------------------------------------+
| client_control_mode | 1 if client is in control mode        |
+---------------------+---------------------------------------+
| client_height       | Height of client                      |
+---------------------+---------------------------------------+
| client_key_table    | Current key table                     |
+---------------------+---------------------------------------+
| client_last_session | Name of the client’s last session     |
+---------------------+---------------------------------------+
| client_pid          | PID of client process                 |
+---------------------+---------------------------------------+
| client_prefix       | 1 if prefix key has been pressed      |
+---------------------+---------------------------------------+
| client_readonly     | 1 if client is readonly               |
+---------------------+---------------------------------------+
| client_session      | Name of the client’s session          |
+---------------------+---------------------------------------+
| client_termname     | Terminal name of client               |
+---------------------+---------------------------------------+
| client_tty          | Pseudo terminal of client             |
+---------------------+---------------------------------------+
| client_utf8         | 1 if client supports utf8             |
+---------------------+---------------------------------------+
| client_width        | Width of client                       |
+---------------------+---------------------------------------+
| line                | Line number in the list               |
+---------------------+---------------------------------------+

Panes
+++++

+----------------------+-------------------------------------+
| Variable name        | Description                         |
+----------------------+-------------------------------------+
| alternate_on         | If pane is in alternate screen      |
+----------------------+-------------------------------------+
| alternate_saved_x    | Saved cursor X in alternate screen  |
+----------------------+-------------------------------------+
| alternate_saved_y    | Saved cursor Y in alternate screen  |
+----------------------+-------------------------------------+
| cursor_flag          | Pane cursor flag                    |
+----------------------+-------------------------------------+
| cursor_x             | Cursor X position in pane           |
+----------------------+-------------------------------------+
| cursor_y             | Cursor Y position in pane           |
+----------------------+-------------------------------------+
| insert_flag          | Pane insert flag                    |
+----------------------+-------------------------------------+
| keypad_cursor_flag   | Pane keypad cursor flag             |
+----------------------+-------------------------------------+
| keypad_flag          | Pane keypad flag                    |
+----------------------+-------------------------------------+
| mouse_any_flag       | Pane mouse any flag                 |
+----------------------+-------------------------------------+
| mouse_button_flag    | Pane mouse button flag              |
+----------------------+-------------------------------------+
| mouse_standard_flag  | Pane mouse standard flag            |
+----------------------+-------------------------------------+
| pane_active          | 1 if active pane                    |
+----------------------+-------------------------------------+
| pane_bottom          | Bottom of pane                      |
+----------------------+-------------------------------------+
| pane_current_command | Current command if available        |
+----------------------+-------------------------------------+
| pane_current_path    | Current path if available           |
+----------------------+-------------------------------------+
| pane_dead            | 1 if pane is dead                   |
+----------------------+-------------------------------------+
| pane_dead_status     | Exit status of process in dead pane |
+----------------------+-------------------------------------+
| pane_height          | Height of pane                      |
+----------------------+-------------------------------------+
| pane_id              | Unique pane ID (Alias: #D)          |
+----------------------+-------------------------------------+
| pane_in_mode         | If pane is in a mode                |
+----------------------+-------------------------------------+
| pane_input_off       | If input to pane is disabled        |
+----------------------+-------------------------------------+
| pane_index           | Index of pane (Alias: #P)           |
+----------------------+-------------------------------------+
| pane_left            | Left of pane                        |
+----------------------+-------------------------------------+
| pane_pid             | PID of first process in pane        |
+----------------------+-------------------------------------+
| pane_right           | Right of pane                       |
+----------------------+-------------------------------------+
| pane_start_command   | Command pane started with           |
+----------------------+-------------------------------------+
| pane_synchronized    | If pane is synchronized             |
+----------------------+-------------------------------------+
| pane_tabs            | Pane tab positions                  |
+----------------------+-------------------------------------+
| pane_title           | Title of pane (Alias: #T)           |
+----------------------+-------------------------------------+
| pane_top             | Top of pane                         |
+----------------------+-------------------------------------+
| pane_tty             | Pseudo terminal of pane             |
+----------------------+-------------------------------------+
| pane_width           | Width of pane                       |
+----------------------+-------------------------------------+
| scroll_region_lower  | Bottom of scroll region in pane     |
+----------------------+-------------------------------------+
| scroll_region_upper  | Top of scroll region in pane        |
+----------------------+-------------------------------------+
| scroll_position      | Scroll position in copy mode        |
+----------------------+-------------------------------------+
| wrap_flag            | Pane wrap flag                      |
+----------------------+-------------------------------------+

Sessions
+++++++++

+-----------------------+------------------------------------------+
| Variable name         | Description                              |
+-----------------------+------------------------------------------+
| session_alerts        | List of window indexes with alerts       |
+-----------------------+------------------------------------------+
| session_attached      | Number of clients session is attached to |
+-----------------------+------------------------------------------+
| session_activity      | Integer time of session last activity    |
+-----------------------+------------------------------------------+
| session_created       | Integer time session created             |
+-----------------------+------------------------------------------+
| session_last_attached | Integer time session last attached       |
+-----------------------+------------------------------------------+
| session_group         | Number of session group                  |
+-----------------------+------------------------------------------+
| session_grouped       | 1 if session in a group                  |
+-----------------------+------------------------------------------+
| session_height        | Height of session                        |
+-----------------------+------------------------------------------+
| session_id            | Unique session ID                        |
+-----------------------+------------------------------------------+
| session_many_attached | 1 if multiple clients attached           |
+-----------------------+------------------------------------------+
| session_name          | Name of session (Alias: #S)              |
+-----------------------+------------------------------------------+
| session_width         | Width of session                         |
+-----------------------+------------------------------------------+
| session_windows       | Number of windows in session             |
+-----------------------+------------------------------------------+

Windows
++++++++

+-----------------------+-----------------------------------------------------------+
| Variable name         | Description                                               |
+-----------------------+-----------------------------------------------------------+
| history_bytes         | Number of bytes in window history                         |
+-----------------------+-----------------------------------------------------------+
| history_limit         | Maximum window history lines                              |
+-----------------------+-----------------------------------------------------------+
| history_size          | Size of history in bytes                                  |
+-----------------------+-----------------------------------------------------------+
| window_activity       | Integer time of window last activity                      |
+-----------------------+-----------------------------------------------------------+
| window_activity_flag  | 1 if window has activity                                  |
+-----------------------+-----------------------------------------------------------+
| window_active         | 1 if window active                                        |
+-----------------------+-----------------------------------------------------------+
| window_bell_flag      | 1 if window has bell                                      |
+-----------------------+-----------------------------------------------------------+
| window_find_matches   | Matched data from the find-window                         |
+-----------------------+-----------------------------------------------------------+
| window_flags          | Window flags (Alias: #F)                                  |
+-----------------------+-----------------------------------------------------------+
| window_height         | Height of window                                          |
+-----------------------+-----------------------------------------------------------+
| window_id             | Unique window ID                                          |
+-----------------------+-----------------------------------------------------------+
| window_index          | Index of window (Alias: #I)                               |
+-----------------------+-----------------------------------------------------------+
| window_last_flag      | 1 if window is the last used                              |
+-----------------------+-----------------------------------------------------------+
| window_layout         | Window layout description, ignoring zoomed window panes   |
+-----------------------+-----------------------------------------------------------+
| window_linked         | 1 if window is linked across sessions                     |
+-----------------------+-----------------------------------------------------------+
| window_name           | Name of window (Alias: #W)                                |
+-----------------------+-----------------------------------------------------------+
| window_panes          | Number of panes in window                                 |
+-----------------------+-----------------------------------------------------------+
| window_silence_flag   | 1 if window has silence alert                             |
+-----------------------+-----------------------------------------------------------+
| window_visible_layout | Window layout description, respecting zoomed window panes |
+-----------------------+-----------------------------------------------------------+
| window_width          | Width of window                                           |
+-----------------------+-----------------------------------------------------------+
| window_zoomed_flag    | 1 if window is zoomed                                     |
+-----------------------+-----------------------------------------------------------+

Servers
+++++++

+---------------+-----------------------------------------------------+
| Variable name | Description                                         |
+---------------+-----------------------------------------------------+
| host          | Hostname of local host (alias: #H)                  |
+---------------+-----------------------------------------------------+
| host_short    | Hostname of local host (no domain name) (alias: #h) |
+---------------+-----------------------------------------------------+
| socket_path   | Server socket path                                  |
+---------------+-----------------------------------------------------+
| start_time    | Server start time                                   |
+---------------+-----------------------------------------------------+
| pid           | Server PID                                          |
+---------------+-----------------------------------------------------+

Commands
++++++++

For $ tmux list-commands.

+--------------------+-----------------------------------+
| Variable name      | Description                       |
+--------------------+-----------------------------------+
| command_hooked     | Name of command hooked, if any    |
+--------------------+-----------------------------------+
| command_name       | Name of command in use, if any    |
+--------------------+-----------------------------------+
| command_list_name  | Command name if listing commands  |
+--------------------+-----------------------------------+
| command_list_alias | Command alias if listing commands |
+--------------------+-----------------------------------+
| command_list_usage | Command usage if listing commands |
+--------------------+-----------------------------------+

tmux-logger
=============
1. Logging
Toggle (start/stop) logging in the current pane.

Key binding: prefix + shift + p
File name format: tmux-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log
File path: $HOME (user home dir)
Example file: ~/tmux-my-session-0-1-20140527T165614.log
2. "Screen Capture"
Save visible text, in the current pane. Equivalent of a "textual screenshot".

Key binding: prefix + alt + p
File name format: tmux-screen-capture-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log
File path: $HOME (user home dir)
Example file: tmux-screen-capture-my-session-0-1-20140527T165614.log
3. Save complete history
Save complete pane history to a file. Convenient if you retroactively remember you need to log/save all the work.

Key binding: prefix + alt + shift + p
File name format: tmux-history-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log
File path: $HOME (user home dir)
Example file: tmux-history-my-session-0-1-20140527T165614.log

tmux-sessionist
===============
prefix + g - prompts for session name and switches to it. Performs 'kind-of' name completion.
    - Faster than the built-in prefix + s prompt for long session lists.

prefix + C (shift + c) 
	- prompt for creating a new session by name.

prefix + X (shift + x) 
    - kill current session without detaching tmux.

prefix + S (shift + s) 
      - switches to the last session.
      The same as built-in prefix + L that everyone seems to override with some other binding.
      prefix + @ - promote current pane into a new session.
      Analogous to how prefix + ! breaks current pane to a new window.

prefix + t<secondary-key> 
      - join currently marked pane (prefix + m) to current session/window, and switch to it
      secondary-keys::

            h, -, ": join horizontally
            v, |, %: join vertically
            f, @: join full screen

